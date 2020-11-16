package com.forgetfulr.common.utils;

import com.forgetfulr.common.enums.RedisDBEnum;
import com.forgetfulr.common.enums.TupleDO;
import com.forgetfulr.common.exception.RedisException;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.cglib.beans.BeanMap;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.*;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.types.Expiration;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.*;

/**
 * 缓存工具类接口
 *
 * @author caorui
 * @date 2018/1/8
 */
@Component
public class CacheUtil {

    @Resource
    private RedisTemplate redisTemplate;

    private static com.forgetfulr.common.utils.CacheUtil cacheUtil;

    @PostConstruct
    public void init() {
        cacheUtil = this;
    }

    /**
     * HASH set操作，支持pipeline模式
     *
     * @param key
     * @param field
     * @param value
     * @param redisDB
     */
    public static void hashSet(String key, String field, String value, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bField = serializer.serialize(field);
                byte[] bValue = serializer.serialize(value);
                return connection.hSet(bKey, bField, bValue);
            }
        });
    }

    public static void hashSet(String key, Map<String, String> param, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.executePipelined(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();

                byte[] bKey = serializer.serialize(key);
                Iterator<Map.Entry<String, String>> iterator = param.entrySet().iterator();
                Map.Entry<String, String> entry;
                while (iterator.hasNext()) {
                    entry = iterator.next();
                    //值不为空才可以插入
                    if (entry.getValue() != null) {
                        byte[] bField = serializer.serialize(entry.getKey());
                        byte[] bValue = serializer.serialize(entry.getValue());
                        connection.hSet(bKey, bField, bValue);
                    }
                }

                return null;
            }
        });
    }

    public static String hashGet(String key, String field, RedisDBEnum redisDB) {
        String val = (String) cacheUtil.redisTemplate.execute(new RedisCallback<String>() {
            @Override
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bField = serializer.serialize(field);
                byte[] bVal = connection.hGet(bKey, bField);
                if (Objects.isNull(bVal)) {
                    return null;
                }
                return serializer.deserialize(bVal);
            }
        });

        return val;
    }

    public static void hashSetIncr(String key, String field, Long delta, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bField = serializer.serialize(field);

                return connection.hIncrBy(bKey, bField, delta);
            }
        });
    }

    public static void hashSetIncr(String key, String field, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bField = serializer.serialize(field);

                return connection.hIncrBy(bKey, bField, 1);
            }
        });
    }

    /**
     * HASH del操作，支持pipeline模式
     *
     * @param key
     * @param field
     * @param redisDB
     */
    public static void hashDel(String key, String field, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bField = serializer.serialize(field);

                return connection.hDel(bKey, bField);
            }
        });
    }

    /**
     * 对对象key值加上delta
     *
     * @param key
     * @param delta
     * @param redisDB
     * @return
     */
    public static long increment(String key, long delta, RedisDBEnum redisDB) {
        return (Long) cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);

                return connection.incrBy(bKey, delta);
            }
        });
    }

    public static long increment(String key, long delta, Long expireTime, RedisDBEnum redisDB) {
        return (Long) cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                connection.expire(bKey, expireTime);
                return connection.incrBy(bKey, delta);
            }
        });
    }

    public static void listLPush(String key, String val, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = serializer.serialize(val);

                return connection.lPush(bKey, bVal);
            }
        });
    }

    /**
     * redis插入数组队列(左插入)
     * 第一次插入{1,2,3}，第二次插入{4,5}
     * 结果是{4,5,1,2,3}
     *
     * @param key     键
     * @param strs    字符串数组
     * @param redisDB
     * @return
     */
    public static void listLPush(String key, String[] strs, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[][] bytes = new byte[strs.length][];
                for (int i = 0; i < strs.length; i++) {
                    bytes[i] = strs[i].getBytes();
                }
                return connection.lPush(bKey, bytes);
            }
        });
    }

    /**
     * redis插入数组队列（右插入）
     * 第一次插入{1,2,3}，第二次插入{4,5}
     * 结果是{1,2,3,4,5}
     *
     * @param key     键
     * @param strs    字符串数组
     * @param redisDB
     * @return
     */
    public static void listRPush(String key, String[] strs, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[][] bytes = new byte[strs.length][];
                for (int i = 0; i < strs.length; i++) {
                    bytes[i] = strs[i].getBytes();
                }

                return connection.rPush(bKey, bytes);
            }
        });
    }

    /**
     * 获取list区间值
     *
     * @param key        键
     * @param startIndex 起始索引，从0开始
     * @param endIndex   -1表示最后一个元素
     * @param redisDB
     * @return
     */
    public static List<String> listLRange(String key, long startIndex, long endIndex, RedisDBEnum redisDB) {
        List<String> resultList = (List<String>) cacheUtil.redisTemplate.execute(new RedisCallback<List<String>>() {
            @Override
            public List<String> doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                List<byte[]> byteList = connection.lRange(bKey, startIndex, endIndex);
                List<String> stringList = new ArrayList<>();
                byteList.stream().forEach(bytes -> stringList.add(serializer.deserialize(bytes)));
                return stringList;
            }
        });

        return resultList;
    }

    public static String listRPop(String key, RedisDBEnum redisDB) {
        Object val = cacheUtil.redisTemplate.execute(new RedisCallback<String>() {
            @Override
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = connection.rPop(bKey);
                if (bVal == null) {
                    return null;
                }

                return serializer.deserialize(bVal);
            }
        });

        return Objects.isNull(val) ? null : (String) val;
    }

    /**
     * 左删除
     *
     * @param key
     * @param redisDB
     * @return
     */
    public static String listLPop(String key, RedisDBEnum redisDB) {
        Object val = cacheUtil.redisTemplate.execute(new RedisCallback<String>() {
            @Override
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = connection.lPop(bKey);
                if (bVal == null) {
                    return null;
                }

                return serializer.deserialize(bVal);
            }
        });

        return Objects.isNull(val) ? null : (String) val;
    }

    public static Map hashGetAll(String key, RedisDBEnum redisDB) {
        Map pairs = (Map) cacheUtil.redisTemplate.execute(new RedisCallback<Map>() {
            @Override
            public Map doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);

                Map<byte[], byte[]> map = connection.hGetAll(bKey);
                Map pairs = new HashMap();
                if (map != null) {
                    Iterator iterator = map.entrySet().iterator();
                    Map.Entry entry;
                    while (iterator.hasNext()) {
                        entry = (Map.Entry) iterator.next();
                        pairs.put(serializer.deserialize((byte[]) entry.getKey()), serializer.deserialize((byte[]) entry.getValue()));
                    }
                }

                return pairs;
            }
        });

        return pairs;
    }

    /**
     * @param key
     * @param value
     * @param expiry  秒
     * @param redisDB
     */
    public static void set(String key, String value, Long expiry, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = serializer.serialize(value);

                connection.set(bKey, bVal, Expiration.seconds(expiry), RedisStringCommands.SetOption.UPSERT);

                return true;
            }
        });
    }

    /**
     * @param key
     * @param value
     * @param redisDB
     */
    public static void set(String key, String value, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = serializer.serialize(value);

                connection.set(bKey, bVal);

                return true;
            }
        });
    }

    public static String get(String key, RedisDBEnum redisDB) {
        Object val = cacheUtil.redisTemplate.execute(new RedisCallback<String>() {
            @Override
            public String doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = connection.get(bKey);
                if (Objects.isNull(bVal)) {
                    return null;
                }

                return serializer.deserialize(bVal);
            }
        });

        return Objects.isNull(val) ? null : (String) val;
    }

    /**
     * 发布接口
     *
     * @param channel
     * @param message
     */
    public static void publish(String channel, String message) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bChannel = serializer.serialize(channel);
                byte[] bMessage = serializer.serialize(message);
                return connection.publish(bChannel, bMessage);
            }
        });
    }

    /**
     * 获取分布式锁，只适用单节点
     *
     * @param key
     * @param value
     * @param expiry  时间毫秒数
     * @param redisDB
     * @return 1表示成功；其他表示未获取成功
     */
    public static long tryLock(String key, String value, Long expiry, RedisDBEnum redisDB) {
        Object val = cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                String script = "local bakval = redis.call('SET', KEYS[1], ARGV[1], ARGV[2], ARGV[3], ARGV[4]) if (bakval and bakval.ok) == 'OK' then return 1 else return 0 end";
                byte[] bScript = serializer.serialize(script);
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = serializer.serialize(value);
                byte[] bPX = serializer.serialize("PX");
                byte[] bExpiry = serializer.serialize(expiry.toString());
                byte[] bNX = serializer.serialize("NX");

                return connection.eval(bScript, ReturnType.INTEGER, 1, bKey, bVal, bPX, bExpiry, bNX);
            }
        });

        return Objects.isNull(val) ? 0 : (Long) val;
    }

    /**
     * 释放分布式锁，只适用单节点
     *
     * @param key
     * @param value
     * @param redisDB
     */
    public static long releaseLock(String key, String value, RedisDBEnum redisDB) {
        Object val = cacheUtil.redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                String script = "if redis.call('GET', KEYS[1]) == ARGV[1] then return redis.call('DEL', KEYS[1]) else return 0 end";
                byte[] bScript = serializer.serialize(script);
                byte[] bKey = serializer.serialize(key);
                byte[] bVal = serializer.serialize(value);

                return connection.eval(bScript, ReturnType.INTEGER, 1, bKey, bVal);
            }
        });

        return Objects.isNull(val) ? 0 : (Long) val;
    }

    private static RedisSerializer<String> getRedisSerializer() {
        return cacheUtil.redisTemplate.getStringSerializer();
    }

    /**
     * 根据key去匹配获取相似key集合(keys如果在有很多key的请款下有性能问题，线上代码不建议使用)
     *
     * @param key
     * @param redisDB
     * @return
     */
    @Deprecated
    public static Set<String> getKeys(String key, RedisDBEnum redisDB) {
        Set<String> set = (Set<String>) cacheUtil.redisTemplate.execute(new RedisCallback<Set<String>>() {
            @Override
            public Set<String> doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bKey = serializer.serialize(key + "*");
                Set<byte[]> bSet = connection.keys(bKey);
                if (Objects.isNull(bSet)) {
                    return null;
                }
                Set<String> resultSet = new HashSet<>();
                bSet.stream().forEach(key -> resultSet.add(serializer.deserialize(key)));
                return resultSet;
            }
        });

        return set;
    }

    /**
     * 返回指定cls类型的实体类
     *
     * @param key
     * @param cls
     * @param redisDB
     * @param <T>
     * @return
     * @throws Exception
     */
    public static <T> T hashGetAll(String key, Class<T> cls, RedisDBEnum redisDB) throws Exception {
        Map pairs = hashGetAll(key, redisDB);
        T t = cls.newInstance();
        BeanUtils.populate(t, pairs);
        return t;
    }

    /**
     * 根据keys集合获取对应keys的list值集合
     *
     * @param keySet
     * @param redisDB
     * @return
     */
    public static <T> List<T> hashGetAllBykeys(Set<String> keySet, Class<T> cls, RedisDBEnum redisDB) throws Exception {
        List<Map> list = (List<Map>) cacheUtil.redisTemplate.execute(new RedisCallback<List<Map>>() {
            @Override
            public List<Map> doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                List<Map> list = new ArrayList<>();
                for (String key : keySet) {
                    byte[] bKey = serializer.serialize(key);
                    Map<byte[], byte[]> map = connection.hGetAll(bKey);
                    if (map != null) {
                        Map pairs = new HashMap();
                        Iterator iterator = map.entrySet().iterator();
                        Map.Entry entry;
                        while (iterator.hasNext()) {
                            entry = (Map.Entry) iterator.next();
                            pairs.put(serializer.deserialize((byte[]) entry.getKey()), serializer.deserialize((byte[]) entry.getValue()));
                        }
                        list.add(pairs);
                    }
                }
                return list;
            }
        });
        List<T> resultList = new ArrayList<>();
        for (Map map : list) {
            T t = cls.newInstance();
            BeanUtils.populate(t, map);
            resultList.add(t);
        }
        return resultList;
    }

    /**
     * 将maplist以key+suffixValue作为key批量存入redis
     *
     * @param key       统一前缀
     * @param paramList 存储对象list
     * @param suffix    后缀值的key，比如user统一前缀为USER_,suffix就是id,连接符统一为"_"
     * @param redisDB
     */
    public static <T> void bashHashSet(String key, List<T> paramList, RedisDBEnum redisDB, String... suffix) {
        cacheUtil.redisTemplate.executePipelined(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                paramList.forEach(obj -> {
                    Map<byte[], byte[]> map = new HashMap<>();
                    BeanMap beanMap = BeanMap.create(obj);
                    transferToBytesMap(beanMap, map, serializer);
                    //生成key
                    String mapKey = key;
                    for (int i = 0; i < suffix.length; i++) {
                        if (i > 0) {
                            mapKey += "_";
                        }
                        Object suffixValue = beanMap.get(suffix[i]);
                        mapKey += suffixValue;
                    }
                    byte[] bmapKey = serializer.serialize(mapKey);
                    //将map存入redis
                    connection.hMSet(bmapKey, map);
                });
                return null;
            }
        });
    }


    /**
     * 有序集添加数据
     *
     * @param key
     * @param tuples
     * @param redisDB
     */
    public static void sortSetAdd(String key, Set<TupleDO> tuples, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.executePipelined(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bkey = serializer.serialize(key);
                Set<RedisZSetCommands.Tuple> set = new HashSet<>();
                tuples.forEach(tupleDO -> {
                    byte[] bvalue = serializer.serialize(tupleDO.getValue());
                    RedisZSetCommands.Tuple tuple = new DefaultTuple(bvalue, tupleDO.getScore());
                    set.add(tuple);
                });
                connection.zAdd(bkey, set);
                return null;
            }
        });
    }

    /**
     * 获取有序集合区间值
     *
     * @param key        键
     * @param startIndex 起始索引，从0开始
     * @param endIndex   -1表示最后一个元素
     * @param redisDB
     * @return
     */
    public static List<String> sortedSetRange(String key, long startIndex, long endIndex, RedisDBEnum redisDB) {
        List<String> list = (List<String>) cacheUtil.redisTemplate.execute(new RedisCallback<List<String>>() {
            @Override
            public List<String> doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bkey = serializer.serialize(key);
                Set<byte[]> set = connection.zRange(bkey, startIndex, endIndex);
                List<String> resultList = new ArrayList<>();
                set.forEach(value -> resultList.add(serializer.deserialize(value)));
                return resultList;
            }
        });
        return list;
    }

    /**
     * 批量删除(keys如果在有很多key的情况下有性能问题，线上代码不建议使用)
     *
     * @param keys
     * @param redisDB
     */
    @Deprecated
    public static void bashDel(Set<String> keys, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.executePipelined(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                for (String key : keys) {
                    byte[] bkey = serializer.serialize(key);
                    connection.del(bkey);
                }
                return null;
            }
        });
    }

    /**
     * 删除
     *
     * @param key
     * @param redisDB
     */
    public static void delKey(String key, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bkey = serializer.serialize(key);
                connection.del(bkey);
                return null;
            }
        });
    }


    /**
     * 重试取锁
     *
     * @param key        锁key
     * @param value      锁value
     * @param expireTime 锁失效时间
     * @param tryTimes   取锁重试次数
     * @param sleepTime  重试间隔毫秒
     * @throws Exception
     */
    public static long getLock(String key, String value, Long expireTime, Integer tryTimes, Long sleepTime) throws RedisException {
        if (sleepTime == null || sleepTime == 0L || sleepTime > 5000L) {
            sleepTime = 1000L;
        }
        if (tryTimes > 10) {
            tryTimes = 10;
        }
        long lock = tryLock(key, value, expireTime, RedisDBEnum.DB_LOCK);
        int time = 0;
        while (lock != 1) {
            time++;
            try {
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if (time > tryTimes) {
                throw new RedisException("redis 获取锁超时");
            }
            lock = tryLock(key, value, expireTime, RedisDBEnum.DB_LOCK);
        }
        return lock;
    }

    /**
     * hashSet简化版,直接把bean丢进来就行了
     *
     * @param key     键名
     * @param t       类名
     * @param redisDB index
     * @param <T>
     */
    public static <T> void hashSet(String key, T t, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.executePipelined(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                Map<byte[], byte[]> map = new HashMap<>();
                BeanMap beanMap = BeanMap.create(t);
                transferToBytesMap(beanMap, map, serializer);
                //生成key
                byte[] bmapKey = serializer.serialize(key);
                //将map存入redis
                connection.hMSet(bmapKey, map);
                return null;
            }
        });
    }

    public static <T> void hashSet(String key, T t, Long expireTime, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.executePipelined(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                Map<byte[], byte[]> map = new HashMap<>();
                BeanMap beanMap = BeanMap.create(t);
                transferToBytesMap(beanMap, map, serializer);
                //生成key
                byte[] bmapKey = serializer.serialize(key);
                //将map存入redis
                connection.hMSet(bmapKey, map);
                connection.expire(bmapKey, expireTime);
                return null;
            }
        });
    }

    /**
     * 提取方法，将beanMap转让bytesMap
     *
     * @param beanMap
     * @param map
     * @param serializer
     */
    private static void transferToBytesMap(BeanMap beanMap, Map<byte[], byte[]> map, RedisSerializer<String> serializer) {
        beanMap.keySet().forEach(key -> {
            Object value = beanMap.get(key);
            if (value != null) {
                byte[] bkey = serializer.serialize(key == null ? null : String.valueOf(key));
                byte[] bvalue = serializer.serialize(String.valueOf(value));
                map.put(bkey, bvalue);
            }
        });
    }

    /**
     * 设置键过期时间
     *
     * @param key
     * @param expireTime 失效时间（秒）
     * @param redisDB
     */
    public static void expireKey(String key, Long expireTime, RedisDBEnum redisDB) {
        cacheUtil.redisTemplate.execute(new RedisCallback() {
            @Override
            public Object doInRedis(RedisConnection connection) throws DataAccessException {
                connection.select(redisDB.getDbIndex());
                RedisSerializer<String> serializer = getRedisSerializer();
                byte[] bkey = serializer.serialize(key);
                connection.expire(bkey, expireTime);
                return null;
            }
        });
    }
}
