package com.amei.interceptor;

import com.amei.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 创建拦截器的步骤：1.先新建一个类实现HandlerInterceptor接口
 * 2.重写3个方法，补全preHandle逻辑
 * 3.在核心配置文件中配置拦截器
 *
 * 用途：登录拦截、权限拦截   、
 */
public class LoginInterceptor implements HandlerInterceptor {
    /**
     * 在执行Handler业务之前执行
     *
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 在Handler业务方法执行之前判断用户是否已登录
        User user =  (User)request.getSession().getAttribute("user");
        if(user!=null){
            return true;  // 返回true, 执行具体的Handler或者是下一个拦截器
        }else{
            response.sendRedirect(request.getContextPath()+"/showMain"); // 重定向到登录页面的请求
            return false;     // 返回false,不再向下执行Handler业务逻辑
        }

    }

    // 在Handler业务逻辑处理之后执行，但是在返回视图渲染之前被调用
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }


    // 在视图渲染之后执行
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
