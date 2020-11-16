package com.yujia.topbang.api.controller.aop;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.forgetfulr.common.utils.SystemUtil;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * 后端接口权限校验
 * <p>
 * 详细的配置示例看官网https://docs.spring.io/spring/docs/current/spring-framework-reference/core.html#aop
 *
 * @author caorui
 * @date 2019-02-22
 */
@Slf4j
@Aspect
@Component
public class ApiOperationAspect {

    /**
     * 定义切片为在controller.mgr下的所有类方法
     */
    @Pointcut("execution(public * com.yujia.topbang.api.controller.mgr..*.*(..))")
    public void authMgr() {

    }

    @Around("authMgr()")
    public Object dobefore(ProceedingJoinPoint joinPoint) throws Throwable {
        try {
            Long userId = SystemUtil.manageUserId();
            if (ObjectUtil.isNullOrEmpty(userId) || userId <= 0) {
                throw new UserException("无效的登录信息");
            }
            // 鉴权
        } catch (UserException e) {
            // 返回自定义异常
            // 直接return就不会继续执行
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
        // 放行操作
        return joinPoint.proceed();
    }
}