#欢迎界面
def welcome():
    print ("*****欢迎使用手机性能测试软件*****")

    while True:
        try:
            times = int(input('请输入测试次数'))
        except ValueError:
            print('输入错误，请输入正整数')
        else:
            if times > 0:
                break
            else:
                print('输入错误，请输入正整数')
    return times
