# APP UI test about kaoyan.apk
## How to run:
- 1. plug Android phone in the computer;
- 2. Run Appium on the computer;
- 2. run 'pytest --alluredir=report' on the command-line terminal
- 3. after testing, you can check the result in the result_date/login_data.xlsx
- 4. and then run 'allure serve report' on the command-line terminal, and you can read the report on brower.
- 5. You can also check the snapshot pictures in the path 'screenshots'.

## Function:
test APP's UI function on Android phone
There are three sences:
 1.APP is running at the front desk, we get the information of CPU, MEM, battery and flow.
 2.APP is running in the monkey mode, we get the information of CPU, MEM, battery, flow and monkey log.
 3.APP is running in the background, we get the information of CPU, MEM, battery and flow.

notes:
1.The apk file will install in the phone automatically.
2.The result will be saved in the path named 'result_data',in a file named 'login_data.xlsx' automatically.

