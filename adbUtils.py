# -*- coding: UTF-8 -*-
'''
该模块封装了所有adb命令
'''

import my_logging
import os 
from time import sleep
import openpyxl

logger = my_logging.MyLogging().getlogger()

class Adb():
    ''' 执行adb命令'''
    def __init__(self,apk_name,package_name, activity_name):
        self.apk_name = apk_name
        self.package_name = package_name
        self.activity_name = activity_name

    def install_app(self):
        cmd_install = "adb install " + self.apk_name
        return os.popen(cmd_install)
    
    def start_app(self):
        cmd_start = "adb shell am start -W -n " + self.package_name + '/' + self.activity_name
        os.popen(cmd_start)
        print('app started')
        sleep(1)

    def kill_app(self):
        cmd_killapp = 'adb shell am force-stop ' + self.package_name  #关闭进程
        os.popen(cmd_killapp)
        print('app killed')

    def callback_app(self):
        cmd_callback = 'adb shell input keyevent 3'  #将程序置于后台
        os.popen(cmd_callback)

    def monkey_commond(self,times,path):
        print('----------monkey testing----------')
        cmd_monkey = 'adb shell monkey -p ' + self.package_name + \
              ' --throttle 100 -v-v ' + str(times*120) + ' > '+path+'monkey.log 2>&1'
        logger.debug(cmd_monkey)
        os.system(cmd_monkey)

    def apk_info(self):
        #判断apk是否安装
        cmd_apk_info = 'adb shell pm list packages | findstr ' + self.package_name
        return os.popen(cmd_apk_info)

    def cpuinfo(self):
        cmd_cpu = 'adb shell top -n 1 | findstr ' + self.package_name 
        return os.popen(cmd_cpu)

    def meminfo(self):
        cmd_mem = 'adb shell dumpsys meminfo | findstr ' + self.package_name 
        return os.popen(cmd_mem)

    def ps_info(self):
        cmd_ps = 'adb shell ps |findstr ' + self.package_name
        return os.popen(cmd_ps)

    def monkey_info(self):
        cmd_ps = 'adb shell ps |findstr monkey'
        return os.popen(cmd_ps)

    def flow_info(self,new_Uid):
        cmd_flow = 'adb shell cat /proc/net/xt_qtaguid/stats |findstr ' + new_Uid
        return os.popen(cmd_flow)

    def battery_info(self,Uid):
        cmd_battery = 'adb shell dumpsys batterystats | findstr '+ Uid
        return os.popen(cmd_battery)
    
    def restart_server(self):
        cmd_kill_server = 'adb kill-server'
        cmd_start_server = 'adb start-server'
        os.popen(cmd_kill_server)
        sleep(2)
        os.popen(cmd_start_server)
        sleep(2)
    
