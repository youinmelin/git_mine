# -*- coding: UTF-8 -*

'''
       app在前台时，同时获取cpu、内存、电量、流量
       app在运行monkey时，同时获取cpu、内存、电量、流量和monkey日志
       app在后台时，同时获取cpu、内存、电量、流量
'''
import time
import my_logging
import testEngine
from multiprocessing import Pool
from adbUtils import Adb
from save_txt_to_xlsx import SaveTxtToXlsx
import os
import welcome
from time import sleep

logger = my_logging.MyLogging().getlogger()

class Controller():
    def __init__(self,times,apk_name,package_name,activity_name,path):
        #运行次数
        self.times = times
        self.apk_name = apk_name
        self.package_name = package_name
        self.activity_name =activity_name
        self.path = path
    def build_test(self):
        try:
            # 创建存放记录结果的文件夹
            os.mkdir(path[0:-1]) #创建dir时去掉最后的'/'
        except Exception as e:
            # 删除所有记录结果的文件
            for filename in os.listdir(self.path):
                os.remove(self.path+filename)
            logger.debug (e)

        get_data = testEngine.RunTest(self.apk_name,self.package_name,self.activity_name,self.path)
        adb_cmd = Adb(self.apk_name,self.package_name,self.activity_name)
        #先断开再重新连接adb设备
        adb_cmd.restart_server() # kill and start adb server

        #如果apk没有安装，执行安装程序
        while True:
            if not adb_cmd.apk_info().readline():
                adb_cmd.install_app()
                print('软件不存在，正在安装')
                sleep(15)  #等待15秒，重新判断是否安装
            else:
                print("软件已安装，准备进入测试")
                break

        adb_cmd.start_app()
        # 场景1：软件在前台
        po = Pool(5)
        po.apply_async(get_data.meminfo,(self.times,'front'))
        po.apply_async(get_data.cpuinfo,(self.times,'front'))
        po.apply_async(get_data.batteryinfo,(self.times,'front'))
        po.apply_async(get_data.flowinfo,(self.times,'front'))
        po.close()
        po.join()
        adb_cmd.kill_app()
        
        #每个场景初始化，恢复环境（先kill APP 再 start app)
        adb_cmd.start_app()
        # 场景2：软件在monkey下运行
        po = Pool(5)  #进程池中最多同时运行N个进程
        po.apply_async(adb_cmd.monkey_commond,args=(self.times,self.path,))
        po.apply_async(get_data.meminfo,(self.times,'monkey'))
        po.apply_async(get_data.cpuinfo,(self.times,'monkey'))
        po.apply_async(get_data.batteryinfo,(self.times,'monkey'))
        po.apply_async(get_data.flowinfo,(self.times,'monkey'))
        po.close()
        #进程池所有进程都结束后，再向下执行，可以保证monkey运行完成
        po.join() 
        adb_cmd.kill_app()

        adb_cmd.start_app()
        # 场景3：软件在后台
        adb_cmd.callback_app()
        po = Pool(5)
        po.apply_async(get_data.meminfo,(self.times,'back'))
        po.apply_async(get_data.cpuinfo,(self.times,'back'))
        po.apply_async(get_data.batteryinfo,(self.times,'back'))
        po.apply_async(get_data.flowinfo,(self.times,'back'))
        po.close()
        po.join()
        adb_cmd.kill_app()

if __name__ == "__main__":

    package_name = 'com.tal.kaoyan'
    activity_name = '.ui.activity.SplashActivity'
    apk_name = 'apk\\kaoyan.apk'
    times = welcome.welcome()
    path = 'result/'
    controller = Controller(times,apk_name,package_name,activity_name,path)
    controller.build_test()
    savetoxlsx = SaveTxtToXlsx(path)
    savetoxlsx.save_to_list()
    print("testing finished")
