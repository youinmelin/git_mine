import { asyncRouterMap, constantRouterMap } from '@/router'

/**
 * 通过meta.role判断是否与当前用户权限匹配
 * @param roles
 * @param route
 */
function hasPermission(roles, route) {
  if (route.meta && route.meta.roles) {
    // return roles.some(role => route.meta.roles.indexOf(role) >= 0)
    for (var i = 0; i < route.meta.roles.length; i++) {
      for (var j = 0; j < roles.length; j++) {
        if (route.meta.roles[i] === roles[j].name) {
          return true
        }
      }
    }
    return false
  } else {
    return false
  }
}

/**
 * 递归过滤异步路由表，返回符合用户角色权限的路由表
 * @param asyncRouterMap
 * @param roles
 */
function filterAsyncRouter(asyncRouterMap, roles) {
  const accessedRouters = asyncRouterMap.filter(route => {
    if (hasPermission(roles, route)) {
      if (route.children && route.children.length) {
        route.children = filterAsyncRouter(route.children, roles)
      }
      return true
    }
    return false
  })
  return accessedRouters
}

/**
 * 检测指定的角色是否在角色列表中
 *
 * @param detectedRole
 * @param roles
 */
function detectRole(detectedRole, roles) {
  if (roles) {
    for (var i = 0; i < roles.length; i++) {
      if (roles[i].name === detectedRole) {
        return true
      }
    }

    return false
  }
}

const permission = {
  state: {
    routers: constantRouterMap,
    addRouters: []
  },
  mutations: {
    SET_ROUTERS: (state, routers) => {
      state.addRouters = routers
      state.routers = constantRouterMap.concat(routers)
    }
  },
  actions: {
    GenerateRoutes({ commit }, data) {
      return new Promise(resolve => {
        const { roles } = data
        let accessedRouters
        if (detectRole('admin', roles)) {
          accessedRouters = asyncRouterMap
        } else {
          accessedRouters = filterAsyncRouter(asyncRouterMap, roles)
        }
        commit('SET_ROUTERS', accessedRouters)
        resolve()
      })
    }
  }
}

export default permission
