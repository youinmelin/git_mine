# -*- coding: UTF-8 -*-
import pytest
from login import Login
from tools.xlsx_to_list import XlsxToList
from tools.save_value_to_cell_xl import ValueToCell
import my_logging
import os

logger = my_logging.MyLogging().getlogger()

def get_list_func():
    get_list = XlsxToList('data/','login_data.xlsx')
    login_list = get_list.save_list()
    test_list = []
    i = True
    for t_list in login_list:
        if i == True:
            #跳过第一行标题行
            i = False
            continue
        row_list = []
        row_list=(t_list[0],t_list[3],t_list[4],t_list[5])

        test_list.append(row_list)
    return (test_list)

test_list = get_list_func()
lin = Login()
os.popen('copy /Y data/login_data.xlsx result_data/login_data.xlsx')

@pytest.mark.parametrize('line,username,password,expect',test_list)
def test_login(line,username,password,expect):
    result = lin.login_case(username,password)
    line = int(line)+1   #跳过标题行
    save_result_xlsx = ValueToCell(line,7,result,r'result_data/','login_data.xlsx')
    save_result_xlsx.save_value()
    logger.debug((result,expect))
    assert expect in result
