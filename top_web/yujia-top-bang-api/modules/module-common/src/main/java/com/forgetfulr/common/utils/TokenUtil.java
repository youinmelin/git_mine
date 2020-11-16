package com.forgetfulr.common.utils;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Token工具包
 * 创建规则遵从JWT协议规范
 * 网址：https://jwt.io/
 *
 * @author caorui
 */
public class TokenUtil {

    private static final byte[] SECRET_KEY = {112, 97, 115, 115, 119, 111, 114, 100};

    private static final Algorithm ALGORITHM = Algorithm.HMAC512(SECRET_KEY);

    /**
     * 签发者
     */
    private static final String JWT_ISSUER = "www.mingyou.com";

    /**
     * 签发主题
     */
    private static final String JWT_SUBJECT = "auth";

    /**
     * 默认超时时间365天
     */
    private static final Long EXPIRES_MS = 24 * 365 * 60 * 60 * 1000L;

    /**
     * 创建Token
     *
     * @param claims
     * @return
     */
    public static String create(Map<String, String> claims) {
        String token;

        JWTCreator.Builder builder = JWT.create();
        builder.withIssuer(JWT_ISSUER);
        builder.withSubject(JWT_SUBJECT);

        // 添加claim
        Iterator<Map.Entry<String, String>> iterator = claims.entrySet().iterator();
        Map.Entry<String, String> entry;
        while (iterator.hasNext()) {
            entry = iterator.next();
            builder.withClaim(entry.getKey(), entry.getValue());
        }

        // 刷新token有效时间（时间戳），默认为14天
        builder.withClaim("refresh_time", DateUtil.getTimeStampAddDay(14));
        // 签发时间
        builder.withIssuedAt(new Date(System.currentTimeMillis()));
        // 过期时间
        builder.withExpiresAt(new Date(System.currentTimeMillis() + EXPIRES_MS));
        token = builder.sign(ALGORITHM);

        return token;
    }

    /**
     * 认证Token合法性
     *
     * @param token to verify and parse
     * @return HashMap with claim content
     * @throws JWTVerificationException
     */
    public static HashMap<String, String> verify(String token) throws JWTVerificationException {
        HashMap<String, String> claims = new HashMap<>();

        JWTVerifier verifier = JWT.require(ALGORITHM).build();
        DecodedJWT jwt = verifier.verify(token);

        Map<String, Claim> claimMap = jwt.getClaims();
        Iterator<Map.Entry<String, Claim>> iterator = claimMap.entrySet().iterator();
        Map.Entry<String, Claim> entry;
        while (iterator.hasNext()) {
            entry = iterator.next();
            claims.put(entry.getKey(), entry.getValue().asString());
        }

        return claims;
    }

}
