---
title: dotnet 利用表达式进行类型转换
updated: 2023-05-05 06:30:45Z
created: 2023-05-05 06:30:27Z
tags:
  - dotnet
---

### 主要思想:
* 两个不同的类进行映射
* 利用for循环找到相同的属性
* 利用表达式把属性的赋值过程给存下来生成 表达式list
* 真正使用的时候, 只需要读取表达式list进行赋值就好


```
namespace Common
{

    using NLog;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Linq;
    using System.Linq.Expressions;

    public static class Mapper<TSource, TDestination>
        where TSource : class
        where TDestination : class, new()
    {
        
        private static readonly ILogger Logger = LogManager.GetCurrentClassLogger();

        private static readonly Type[] NotReferenceType = new Type[] { typeof(Google.Protobuf.WellKnownTypes.Timestamp) };

        public readonly static Func<TSource, TDestination> MapperFunc = GetMapperFunc();

        public readonly static Action<TSource, TDestination> MapperAction = GetMapperAction();

        public static TDestination MapTo(TSource source, Action<TSource, TDestination> action = null)
        {
            if (source == null)
            {
                Logger.Warn("The parameter ('source') cannot be null.");
                return null;
            }

            var target = MapperFunc(source);
            action?.Invoke(source, target);
            return target;
        }

        public static List<TDestination> MapToList(IEnumerable<TSource> sources, Action<TSource, TDestination> action = null)
        {
            if (sources == null)
            {
                Logger.Error($"The parameter ('sources') cannot be null.");
                throw new ArgumentNullException($"The parameter('sources') cannot be null.");
            }

            var list = new List<TDestination>();
            foreach (var item in sources)
            {
                list.Add(MapTo(item, action));
            }
            return list;
        }

        #region Private Method
        private static Func<TSource, TDestination> GetMapperFunc()
        {
            return source =>
            {
                var target = new TDestination();
                MapperAction(source, target);
                return target;
            };
        }

        private static Action<TSource, TDestination> GetMapperAction()
        {
            //获取源类型和指向类型
            var sourceType = typeof(TSource);
            var destinationType = typeof(TDestination);

            //创建Expression参数
            var sourceParameter = Expression.Parameter(sourceType, "x");
            var destinationParameter = Expression.Parameter(destinationType, "p");

            //创建Expression集合
            var expressionList = new List<Expression>();

            //获取TDestination中的所有允许写入权限的Public属性 或 RepeatedField 属性
            var destinationProperties = destinationType.GetProperties()
                .Where(x => (x.PropertyType.IsPublic || x.PropertyType.IsNestedPublic)
                            && (x.CanWrite || x.PropertyType.FullName.Contains(typeof(Google.Protobuf.Collections.RepeatedField<>).FullName)));

            var sourceProperties = sourceType.GetProperties()
                .Where(x => x.PropertyType.IsPublic || x.PropertyType.IsNestedPublic);
            foreach (var destinationPropertyInfo in destinationProperties)
            {
                try
                {
                    //获取匹配的TSource Property
                    var sourcePropertyInfo = sourceProperties.FirstOrDefault(x => string.Compare(x.Name, destinationPropertyInfo.Name) == 0);
                    if (sourcePropertyInfo == null || !sourcePropertyInfo.CanRead || sourcePropertyInfo.PropertyType.IsNotPublic)
                    {
                        continue;
                    }
                    //创建访问属性的表达式
                    var sourceProperty = Expression.Property(sourceParameter, sourcePropertyInfo);
                    var destinationProperty = Expression.Property(destinationParameter, destinationPropertyInfo);

                    //TSource Property不是值类型，并且和TDestination Property不相同
                    if (!sourcePropertyInfo.PropertyType.IsValueType
                        && !NotReferenceType.Contains(sourcePropertyInfo.PropertyType)
                        && sourcePropertyInfo.PropertyType != destinationPropertyInfo.PropertyType
                        && sourcePropertyInfo.PropertyType != typeof(string)
                        && destinationPropertyInfo.PropertyType != typeof(string))
                    {
                        //TSource Property和TDestination Property都是Class
                        if (sourcePropertyInfo.PropertyType.IsClass && destinationPropertyInfo.PropertyType.IsClass
                            && !sourcePropertyInfo.PropertyType.IsArray && !destinationPropertyInfo.PropertyType.IsArray
                            && !sourcePropertyInfo.PropertyType.IsGenericType && !destinationPropertyInfo.PropertyType.IsGenericType)
                        {
                            var expression = GetClassExpression(sourceProperty, sourcePropertyInfo.PropertyType, destinationPropertyInfo.PropertyType);
                            expressionList.Add(Expression.Assign(destinationProperty, expression));
                            continue;
                        }

                        //TSource派生自IEnumerable，TDestination类型为RepeatedField
                        //从C#IEnumerable转到Google ProtoBuffers RepeatedField
                        if (typeof(IEnumerable).IsAssignableFrom(sourcePropertyInfo.PropertyType)
                            && destinationPropertyInfo.PropertyType.FullName.Contains(typeof(Google.Protobuf.Collections.RepeatedField<>).FullName))
                        {
                            var test = Expression.NotEqual(sourceProperty, Expression.Constant(null, sourcePropertyInfo.PropertyType));

                            //获取List泛型参数
                            var sourceArgument = sourcePropertyInfo.PropertyType.IsArray
                                ? sourcePropertyInfo.PropertyType.GetElementType()
                                : sourcePropertyInfo.PropertyType.GetGenericArguments()[0];
                            var destinationArgument = sourcePropertyInfo.PropertyType.IsArray
                                ? destinationPropertyInfo.PropertyType.GetElementType()
                                : destinationPropertyInfo.PropertyType.GetGenericArguments()[0];

                            //构建方法主体
                            var mapperType = typeof(Mapper<,>).MakeGenericType(sourceArgument, destinationArgument);
                            var actionType = typeof(Action<,>).MakeGenericType(sourceArgument, destinationArgument);

                            var methodCall = Expression.Call(mapperType.GetMethod(nameof(MapToList)
                                , new Type[] { sourcePropertyInfo.PropertyType, actionType })
                                , sourceProperty
                                , Expression.Constant(null, actionType));

                            //构建p.columns.addrange(maptolist(x.columns, null))
                            var repeatedFieldType = typeof(Google.Protobuf.Collections.RepeatedField<>)
                                .MakeGenericType(destinationArgument);

                            var callExpression = Expression.Call(
                                destinationProperty
                                , repeatedFieldType.GetMethod("AddRange")
                                , methodCall);
                            var exp = Expression.IfThen(test, callExpression);
                            expressionList.Add(exp);
                            continue;
                        }

                        //TSource 派生自 RepeatedField，TDestination 类型为 IEnumerable
                        //从 Google ProtoBuffers RepeatedField 转到 C#IEnumerable
                        if (sourcePropertyInfo.PropertyType.FullName.Contains(typeof(Google.Protobuf.Collections.RepeatedField<>).FullName)
                            && typeof(IEnumerable).IsAssignableFrom(destinationPropertyInfo.PropertyType))
                        {
                            var test = Expression.NotEqual(sourceProperty, Expression.Constant(null, sourcePropertyInfo.PropertyType));

                            //获取List泛型参数
                            var sourceArgument = destinationPropertyInfo.PropertyType.IsArray
                                ? sourcePropertyInfo.PropertyType.GetElementType()
                                : sourcePropertyInfo.PropertyType.GetGenericArguments()[0];
                            var destinationArgument = destinationPropertyInfo.PropertyType.IsArray
                                ? destinationPropertyInfo.PropertyType.GetElementType()
                                : destinationPropertyInfo.PropertyType.GetGenericArguments()[0];

                            //构建方法主体
                            var mapperType = typeof(Mapper<,>).MakeGenericType(sourceArgument, destinationArgument);
                            var actionType = typeof(Action<,>).MakeGenericType(sourceArgument, destinationArgument);

                            var methodCall = Expression.Call(mapperType.GetMethod(nameof(MapToList)
                                , new Type[] { sourcePropertyInfo.PropertyType, actionType })
                                , sourceProperty
                                , Expression.Constant(null, actionType));

                            var result = Expression.Assign(destinationProperty, methodCall);

                            expressionList.Add(Expression.IfThen(test, result));
                            continue;
                        }

                        //TSource 和 TDestination都是直接或间接派生自IEnumerable
                        if (typeof(IEnumerable).IsAssignableFrom(sourcePropertyInfo.PropertyType)
                            && typeof(IEnumerable).IsAssignableFrom(destinationPropertyInfo.PropertyType))
                        {
                            var expression = GetEnumerableExpression(sourceProperty, sourcePropertyInfo.PropertyType, destinationPropertyInfo.PropertyType);
                            expressionList.Add(Expression.Assign(destinationProperty, expression));
                            continue;
                        }
                    }


                    //可空类型转换到非可空类型，当可空类型值为null时，用默认值赋给目标属性；不为null就直接转换
                    else if (IsNullable(sourcePropertyInfo.PropertyType) && !IsNullable(destinationPropertyInfo.PropertyType))
                    {
                        var hasValueExpression = Expression.Equal(Expression.Property(sourceProperty, "HasValue"), Expression.Constant(true));

                        //C# DateTime?类型转换到ProtoBuffers TimeStamp
                        if (sourcePropertyInfo.PropertyType.FullName.Contains(typeof(DateTime).FullName)
                            && destinationPropertyInfo.PropertyType.FullName.Contains(typeof(Google.Protobuf.WellKnownTypes.Timestamp).FullName))
                        {
                            var timestampType = typeof(Google.Protobuf.WellKnownTypes.Timestamp);

                            var valueExpression = Expression.Condition(hasValueExpression, Expression.Convert(sourceProperty,typeof(DateTime)), Expression.Default(typeof(DateTime)));
                            var callExpression = Expression.Call(valueExpression, typeof(DateTime).GetMethod("ToUniversalTime"));
                            var call = Expression.Call(timestampType.GetMethod("FromDateTime", new Type[] { typeof(DateTime) }), callExpression);
                            var conditionDateTime = Expression.Condition(hasValueExpression, call, Expression.Default(destinationPropertyInfo.PropertyType));
                            expressionList.Add(Expression.Assign(destinationProperty, conditionDateTime));
                        }
                        else 
                        {
                            var condition = Expression.Condition(hasValueExpression, Expression.Convert(sourceProperty, destinationPropertyInfo.PropertyType), Expression.Default(destinationPropertyInfo.PropertyType));
                            expressionList.Add(Expression.Assign(destinationProperty, condition));
                        }
                        continue;
                    }

                    //非可空类型转换到可空类型，直接转换
                    else if (!IsNullable(sourcePropertyInfo.PropertyType) && IsNullable(destinationPropertyInfo.PropertyType))
                    {
                        var memberExpression = Expression.Convert(sourceProperty, destinationPropertyInfo.PropertyType);
                        expressionList.Add(Expression.Assign(destinationProperty, memberExpression));
                        continue;
                    }

                    //ProtoBuffers TimeStamp类型转换到C# DateTime类型
                    else if (sourcePropertyInfo.PropertyType.FullName.Contains(typeof(Google.Protobuf.WellKnownTypes.Timestamp).FullName)
                        && destinationPropertyInfo.PropertyType.FullName.Contains(typeof(DateTime).FullName))
                    {
                        var timestampType = typeof(Google.Protobuf.WellKnownTypes.Timestamp);

                        //var callExpression = Expression.Call(timestampType, nameof(Google.Protobuf.WellKnownTypes.Timestamp.ToDateTime), new Type[] { timestampType }, sourceProperty)
                        var callExpression = Expression.Call(sourceProperty, timestampType.GetMethod("ToDateTime"));
                        expressionList.Add(Expression.Assign(destinationProperty, callExpression));
                        continue;
                    }

                    //C# DateTime类型转换到ProtoBuffers TimeStamp
                    else if (sourcePropertyInfo.PropertyType.FullName.Contains(typeof(DateTime).FullName)
                        && destinationPropertyInfo.PropertyType.FullName.Contains(typeof(Google.Protobuf.WellKnownTypes.Timestamp).FullName))
                    {
                        var timestampType = typeof(Google.Protobuf.WellKnownTypes.Timestamp);
                        var callExpression = Expression.Call(sourceProperty, typeof(DateTime).GetMethod("ToUniversalTime"));
                        var call = Expression.Call(timestampType.GetMethod("FromDateTime", new Type[] { typeof(DateTime) }), callExpression);
                        expressionList.Add(Expression.Assign(destinationProperty, call));
                        continue;
                    }

                    //String 转换 Guid
                    else if (sourcePropertyInfo.PropertyType.FullName.Contains(typeof(string).FullName)
                        && destinationPropertyInfo.PropertyType.FullName.Contains(typeof(Guid).FullName))
                    {
                        var call = Expression.Call(typeof(Guid).GetMethod("Prase", new Type[] { typeof(string) }), sourceProperty);
                        expressionList.Add(Expression.Assign(destinationProperty, call));
                        continue;
                    }

                    else if (sourcePropertyInfo.PropertyType.FullName.Contains(typeof(string).FullName)
                        && destinationPropertyInfo.PropertyType.FullName.Contains(typeof(string).FullName))
                    {
                        var test = Expression.NotEqual(sourceProperty, Expression.Constant(null, sourcePropertyInfo.PropertyType));
                        var ifThenExp = Expression.IfThen(test, Expression.Assign(destinationProperty, sourceProperty));
                        expressionList.Add(ifThenExp);
                        continue;
                    }

                    // Enum
                    else if (sourcePropertyInfo.PropertyType.IsEnum && destinationPropertyInfo.PropertyType.IsEnum)
                    {
                        var convertExpression = Expression.Convert(sourceProperty, destinationPropertyInfo.PropertyType);
                        expressionList.Add(Expression.Assign(destinationProperty, convertExpression));
                        continue;
                    }

                    else if (sourcePropertyInfo.PropertyType != destinationPropertyInfo.PropertyType)
                    {
                        continue;
                    }
                    var assignExpression = Expression.Assign(destinationProperty, sourceProperty);
                    expressionList.Add(assignExpression);
                }
                catch(ArgumentNullException ex)
                {
                    Logger.Error(ex);
                    throw new ArgumentNullException(ex.Message, ex);
                }
                catch(ArgumentException ex)
                {
                    Logger.Error(ex);
                    throw new ArgumentException(ex.Message, ex);
                }
                catch (Exception ex)
                {
                    Logger.Error(ex);
                    throw new InvalidOperationException(ex.Message, ex);
                }
            }

            //当TDestination ！= null，判断TSource是否为null
            var testSource = Expression.NotEqual(sourceParameter, Expression.Constant(null, sourceType));
            var ifTrueSource = Expression.Block(expressionList);
            var conditionSource = Expression.IfThen(testSource, ifTrueSource);

            //判断TDestination是否为空
            var testTarget = Expression.NotEqual(destinationParameter, Expression.Constant(null, destinationType));
            var conditionTarget = Expression.IfThen(testTarget, conditionSource);

            var lambda = Expression.Lambda<Action<TSource, TDestination>>(conditionTarget, sourceParameter, destinationParameter);
            return lambda.Compile();
        }

        private static Expression GetClassExpression(Expression sourceExpression, Type sourcePropertyType, Type destinationPropertyType)
        {
            try
            {
                var test = Expression.NotEqual(sourceExpression, Expression.Constant(null, sourcePropertyType));

                //构建方法主体
                var mapperManagerType = typeof(Mapper<,>).MakeGenericType(sourcePropertyType, destinationPropertyType);
                var actionType = typeof(Action<,>).MakeGenericType(sourcePropertyType, destinationPropertyType);

                var ifTrue = Expression.Call(mapperManagerType.GetMethod(nameof(MapTo), new Type[] { sourcePropertyType, actionType }), sourceExpression, Expression.Constant(null, actionType));
                var ifFalse = Expression.Constant(null, destinationPropertyType);

                var condition = Expression.Condition(test, ifTrue, ifFalse);

                return condition;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                throw new ArgumentException(ex.Message, ex);
            }
        }

        private static Expression GetEnumerableExpression(Expression sourceExpression, Type sourcePropertyType, Type destinationPropertyType)
        {
            try
            {
                var test = Expression.NotEqual(sourceExpression, Expression.Constant(null, sourcePropertyType));

                //获取List泛型参数
                var sourceArgument = sourcePropertyType.IsArray ? sourcePropertyType.GetElementType() : sourcePropertyType.GetGenericArguments()[0];
                var destinationArgument = sourcePropertyType.IsArray ? destinationPropertyType.GetElementType() : sourcePropertyType.GetGenericArguments()[0];

                //构建方法主体
                var mapperManagerType = typeof(Mapper<,>).MakeGenericType(sourceArgument, destinationArgument);
                var actionType = typeof(Action<,>).MakeGenericType(sourceArgument, destinationArgument);

                var methodCall = Expression.Call(mapperManagerType.GetMethod(nameof(MapToList), new Type[] { sourcePropertyType, actionType }), sourceExpression, Expression.Constant(null, sourcePropertyType));

                Expression ifTrue;
                if (destinationPropertyType.Equals(methodCall.Type))
                {
                    ifTrue = methodCall;
                }
                else if (destinationPropertyType.IsArray)
                {
                    //数组，获取泛型TSource，调用ToArray方法转化
                    ifTrue = Expression.Call(typeof(Enumerable), nameof(Enumerable.ToArray), new[] { methodCall.Type.GenericTypeArguments[0] }, methodCall);
                }
                else if (typeof(IDictionary).IsAssignableFrom(destinationPropertyType))
                {
                    //字典，获取泛型TSource，调用ToDictionary方法转化
                    ifTrue = Expression.Call(typeof(Enumerable), nameof(Enumerable.ToDictionary), new[] { methodCall.Type.GenericTypeArguments[0] }, methodCall);
                }
                else
                {
                    ifTrue = Expression.Convert(methodCall, destinationPropertyType);
                }
                var ifFlase = Expression.Constant(null, destinationPropertyType);
                var conditionItem = Expression.Condition(test, ifTrue, ifFlase);

                return conditionItem;
            }
            catch (Exception ex)
            {
                Logger.Error(ex);
                throw new ArgumentException(ex.Message, ex);
            }
        }

        private static bool IsNullable(Type type)
        {
            return type.IsGenericType && type.GetGenericTypeDefinition().Equals(typeof(Nullable<>));
        }
        #endregion
    }
}


```