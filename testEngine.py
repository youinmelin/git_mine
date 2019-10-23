# -*- coding: UTF-8 -*
'''
 实现运行测试，分析数据，并将测试结果分别存在txt文件中，再调用save_txt_to_xlsx存入excel
'''
import os
import time
import re
import my_logging
import adbUtils

logger = my_logging.MyLogging().getlogger()

class RunTest():
    ''' run test program'''
    def __init__(self,apk_name,package_name,activity_name,path):
        self.app = adbUtils.Adb(apk_name,package_name,activity_name)
        self.processing_data = ProcessingData(self.app)
        self.file_path = path

    def cpuinfo(self,times, back):
        if back == 'back':
            print ('----------开始进行后台CPU占用测试----------')
            data_list = [('timestamp','cpuinfo_back')]
            sheet_name = data_list[0][1]
        elif back == 'front':
            print ('----------开始进行前台CPU占用测试----------')
            data_list = [('timestamp','cpuinfo_front')]
            sheet_name = 'cpuinfo_front'
        elif back == 'monkey':
            print ('----------开始进行monkey+cpu占用测试----------')
            data_list = [('timestamp','monkey_cpu')]
            sheet_name = 'monkey+cpuinfo'
        while times > 0:
            timestamp = self.processing_data.record_time()
            cpuinfo = self.processing_data.getcpuinfo()
            savedatatotxt = SaveDataToTxt(data_list,timestamp,cpuinfo,self.file_path)
            savedatatotxt.save_data_to_txt()
            time.sleep(1)
            #print(times)
            times -= 1

    def meminfo(self,times, back):
        if back == 'back':
            print ('----------开始进行后台mem占用测试----------')
            data_list = [('timestamp','meminfo_back')]
            sheet_name = 'meminfo_back'
        elif back == 'front':
            print ('----------开始进行前台mem占用测试----------')
            data_list = [('timestamp','meminfo_front')]
            sheet_name = 'meminfo_front'
        elif back == 'monkey':
            print ('----------开始进行monkey+mem占用测试----------')
            data_list = [('timestamp','monkey_mem')]
            sheet_name = 'monkey+meminfo'
        while times > 0:
            timestamp = self.processing_data.record_time()
            meminfo = self.processing_data.getmeminfo()
            savedatatotxt = SaveDataToTxt(data_list,timestamp,meminfo,self.file_path)
            savedatatotxt.save_data_to_txt()
            time.sleep(1)
            print(times)
            times -= 1
    
    def batteryinfo(self,times, back):
        # reset battery information
        os.popen('adb shell dumpsys batterystats --reset')
        # 将AC/USB充电方式设置成false
        os.popen('adb shell dumpsys battery set ac 0')
        os.popen('adb shell dumpsys battery set usb 0')
        
        if back == 'back':
            print ('----------开始进行后台battery使用测试----------')
            self.app.callback_app()
            data_list = [('timestamp','batteryinfo_back')]
            sheet_name = 'batteryinfo_back'
        elif back == 'front':
            print ('----------开始进行前台battery使用测试----------')
            data_list = [('timestamp','batteryinfo_front')]
            sheet_name = 'batteryinfo_front'
        elif back == 'monkey':
            print ('----------开始进行monkey+battery使用测试----------')
            data_list = [('timestamp','monkey_battery')]
            sheet_name = 'monkey+batteryinfo'
        while times > 0:
            timestamp = self.processing_data.record_time()
            batteryinfo = self.processing_data.getbatteryinfo()
            #print (type((batteryinfo)))
            savedatatotxt = SaveDataToTxt(data_list,timestamp,batteryinfo,self.file_path)
            savedatatotxt.save_data_to_txt()
            time.sleep(1)
            #print(times)
            times -= 1

    def flowinfo(self,times,back):
        if back == 'back':
            print ('----------开始进行后台flow测试----------')
            self.app.callback_app()
            data_list = [('timestamp','flowinfo_back')]
            sheet_name = 'flowinfo_back'
        elif back == 'front':
            print ('----------开始进行前台flow测试----------')
            data_list = [('timestamp','flowinfo_front')]
            sheet_name = 'flowinfo_front'
        elif back == 'monkey':
            print ('----------开始进行monkey+flow测试----------')
            data_list = [('timestamp','monkey_flow')]
            sheet_name = 'monkey+flowinfo'
        while times > 0:
            timestamp = self.processing_data.record_time()
            flowinfo = self.processing_data.getflowinfo()
            savedatatotxt = SaveDataToTxt(data_list,timestamp,flowinfo,self.file_path)
            savedatatotxt.save_data_to_txt()
            time.sleep(1)
            times -= 1
 
class ProcessingData():
    '''完成对数据的处理，如获取时间戳，对命令返回的文字进行拆分提取'''
    def __init__(self,app):
        self.app = app
     #取得当前时间
    def record_time(self):
        return  time.strftime('%Y-%m-%d %H:%M:%S',time.localtime())
     #取得程序的启动时间
    def getlaunchedtime(self):
        content = self.app.start_app()
        for line in  content.readlines():
            if 'ThisTime' in line:
                launchedtime = re.search('\d+',line).group()
                return launchedtime

    def getcpuinfo(self):
        content = self.app.cpuinfo()
        cpuinfo = 0   #设一个初始值，为一会求和做准备
        try:
            for line in content.readlines():
                cpuinfo += int(re.findall('\d+',line)[2]) 
        except Exception as e:
            logger.debug(e)
        return cpuinfo

    def getmeminfo(self):
        content = self.app.meminfo().readline()
        try:
            meminfo = int(re.findall('\d+',content)[0])
        except Exception as e:
            logger.debug(e)
            meminfo = 0
        return meminfo

    def getUid(self):
        content = self.app.ps_info().readline()
        Uid = content.split()[0]
        logger.debug(Uid)
        return Uid

    def getbatteryinfo(self):
        Uid = self.getUid()
        Uid = re.sub('_','',Uid)
        # 用ps命令取到的uid中间有个_，所以要给去掉
        content = self.app.battery_info(Uid)
        for line in content.readlines(): 
            if 'Uid ' in line:
                battery_info_str =line.split()[2]
                return float(battery_info_str)
        return 0

    def getflowinfo(self):
        Uid = self.getUid()
        # 将Uid转换成纯数字格式,取流量值必须要用数字格式的uid
        Uid_tail = int(re.search('[0-9]{1,2}$',Uid).group())
        new_Uid = str(Uid_tail + 10000)
        content = self.app.flow_info(new_Uid)
        flow_info = 0
        try:
            for line in content.readlines():
                #print(line.split())
                rx_bytes = line.split()[5]  #receive data
                tx_bytes = line.split()[7]  #send data
                flow_info += (int(rx_bytes) + int(tx_bytes))
        except Exception as e:
            pass
        return int(flow_info)

class SaveDataToTxt():
    def __init__(self,data_list,*arg):
        #arg[0]:timestamp,arg[1]:cpuinfo,arg[2]:self.file_path
        self.parameter = arg 
        self.list = data_list
    def save_data_to_txt(self):
        filename = self.list[0][1]+'.txt'
        with open(self.parameter[2]+filename,'a') as f:
            f.write(self.parameter[0]+' '+str(self.parameter[1])+'\n')
