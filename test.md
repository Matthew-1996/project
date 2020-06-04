# sku表筛选
```python
#-*- coding:utf-8 -*-
import pandas as pd
#为了方便，在运行前先把SKU LOCALNAME改成SKU_LOCALNAME（sku表）, SKU CODE改成SKU_CODE(两张表)

filename = 'SKU-06010.txt'
sku_dataset = pd.read_table(filename)
filename2 = '资料_商品整理表test.txt'
sku_zl = pd.read_table(filename2)
#打开sku表和整理表

zl_code = list(sku_zl['SKU_CODE'])
sku_dataset = sku_dataset[~sku_dataset.SKU_CODE.isin(zl_code)]
#删除整理表中已有的sku code
sku_dataset['CATEGORYCH'] = sku_dataset['CATEGORYCH'].apply(str)
sku_dataset = sku_dataset[~sku_dataset.CATEGORYCH.str.contains('彩妆|脸部护理')]
sku_dataset['SKU_LOCALNAME'] = sku_dataset['SKU_LOCALNAME'].apply(str)
sku_dataset = sku_dataset[~sku_dataset.SKU_LOCALNAME.str.contains('随机|换购|葡萄籽|玻尿酸|券|肌底液|紧肤水|卸妆|海报|腮红|睫毛|眼线|眼影|眉笔|档|化妆|青春密码|唇膏|唇釉|唇彩|唇线笔|甲油|美甲|粉饼|遮瑕|隔离|粉底|水活喷雾|彩妆|彩装|美颜液|白护|复颜|美白|肌底|自由来|沁润|凝养|雪颜|纤体|清润|恒放|魅力|风盈|清盈|盈爽|时尚珍藏|臻颜|创世|科研|矿物净化|卡片|卡贴|立牌|明信片')]
#删除不需要的类别和关键词

sku_dataset.to_csv(path_or_buf = r'C:\Users\mye\Desktop\jupyter\test.csv', encoding="utf_8_sig")
#导出为csv
```
# bind邮件生成
```python
#先整合好表格，输出月报的内容，再去word改格式
#-*- coding:utf-8 -*-
import pandas as pd
filename = 'bind改.txt'
bind = pd.read_table(filename)

man_MTD1 = bind.loc[0]['man当月人数']
man_MTD2 = bind.loc[0]['man去年占比']
man_MTD3 = bind.loc[1]['man当月人数']
man_MTD4 = bind.loc[1]['man去年占比']
man_MTD5 = bind.loc[24]['man当月人数']
man_MTD6 = bind.loc[24]['man去年占比']
man_MTD7 = bind.loc[25]['man当月人数']
man_MTD8 = bind.loc[25]['man去年占比']

man_R121 = bind.loc[0]['manR12人数']
man_R122 = bind.loc[0]['manR12_L占比']
man_R123 = bind.loc[1]['manR12人数']
man_R124 = bind.loc[1]['manR12_L占比']
man_R125 = bind.loc[24]['manR12人数']
man_R126 = bind.loc[24]['manR12_L占比']
man_R127 = bind.loc[25]['manR12人数']
man_R128 = bind.loc[25]['manR12_L占比']

man_YTD1 = bind.loc[0]['manYTD人数']
man_YTD2 = bind.loc[0]['manYTD_L占比']
man_YTD3 = bind.loc[1]['manYTD人数']
man_YTD4 = bind.loc[1]['manYTD_L占比']
man_YTD5 = bind.loc[24]['manYTD人数']
man_YTD6 = bind.loc[24]['manYTD_L占比']
man_YTD7 = bind.loc[25]['manYTD人数']
man_YTD8 = bind.loc[25]['manYTD_L占比']

hair_MTD1 = bind.loc[0]['hair当月人数']
hair_MTD2 = bind.loc[0]['hair去年占比']
hair_MTD3 = bind.loc[1]['hair当月人数']
hair_MTD4 = bind.loc[1]['hair去年占比']
hair_MTD5 = bind.loc[24]['hair当月人数']
hair_MTD6 = bind.loc[24]['hair去年占比']
hair_MTD7 = bind.loc[25]['hair当月人数']
hair_MTD8 = bind.loc[25]['hair去年占比']

hair_R121 = bind.loc[0]['hairR12人数']
hair_R122 = bind.loc[0]['hairR12_L占比']
hair_R123 = bind.loc[1]['hairR12人数']
hair_R124 = bind.loc[1]['hairR12_L占比']
hair_R125 = bind.loc[24]['hairR12人数']
hair_R126 = bind.loc[24]['hairR12_L占比']
hair_R127 = bind.loc[25]['hairR12人数']
hair_R128 = bind.loc[25]['hairR12_L占比']

hair_YTD1 = bind.loc[0]['hairYTD人数']
hair_YTD2 = bind.loc[0]['hairYTD_L占比']
hair_YTD3 = bind.loc[1]['hairYTD人数']
hair_YTD4 = bind.loc[1]['hairYTD_L占比']
hair_YTD5 = bind.loc[24]['hairYTD人数']
hair_YTD6 = bind.loc[24]['hairYTD_L占比']
hair_YTD7 = bind.loc[25]['hairYTD人数']
hair_YTD8 = bind.loc[25]['hairYTD_L占比']

man_MTD_list = [man_MTD1, man_MTD2, man_MTD3, man_MTD4, man_MTD5, man_MTD6, man_MTD7, man_MTD8]
print('TTL New Binding   {0[0]} (+{0[1]} vs 2019 May)，New Binding Purchaser {0[2]} (+{0[3]} vs 2019 May).'.format(man_MTD_list))
print('TTL Binding rate {0[4]} (+{0[5]} vs 2019 May)，New Binding rate {0[6]} (+{0[7]} vs 2019 May)'.format(man_MTD_list))
man_R12_list = [man_R121, man_R122, man_R123, man_R124, man_R125, man_R126, man_R127, man_R128]
print('TTL New Binding   {0[0]} (+{0[1]} vs L R12)，New Binding Purchaser {0[2]} (+{0[3]} vs L R12).'.format(man_R12_list))
print('TTL Binding rate {0[4]} (+{0[5]} vs L R12)，New Binding rate {0[6]} (+{0[7]} vs L R12)'.format(man_R12_list))
man_YTD_list = [man_YTD1, man_YTD2, man_YTD3, man_YTD4, man_YTD5, man_YTD6, man_YTD7, man_YTD8]
print('TTL New Binding   {0[0]} (+{0[1]} vs L YTD)，New Binding Purchaser {0[2]} (+{0[3]} vs L YTD).'.format(man_YTD_list))
print('TTL Binding rate {0[4]} (+{0[5]} vs L YTD)，New Binding rate {0[6]} (+{0[7]} vs L YTD)'.format(man_YTD_list))
hair_MTD_list = [hair_MTD1, hair_MTD2, hair_MTD3, hair_MTD4, hair_MTD5, hair_MTD6, hair_MTD7, hair_MTD8]
print('TTL New Binding   {0[0]} (+{0[1]} vs 2019 May)，New Binding Purchaser {0[2]} (+{0[3]} vs 2019 May).'.format(hair_MTD_list))
print('TTL Binding rate {0[4]} (+{0[5]} vs 2019 May)，New Binding rate {0[6]} (+{0[7]} vs 2019 May)'.format(hair_MTD_list))
hair_R12_list = [hair_R121, hair_R122, hair_R123, hair_R124, hair_R125, hair_R126, hair_R127, hair_R128]
print('TTL New Binding   {0[0]} (+{0[1]} vs L R12)，New Binding Purchaser {0[2]} (+{0[3]} vs L R12).'.format(hair_R12_list))
print('TTL Binding rate {0[4]} (+{0[5]} vs L R12)，New Binding rate {0[6]} (+{0[7]} vs L R12)'.format(hair_R12_list))
hair_YTD_list = [hair_YTD1, hair_YTD2, hair_YTD3, hair_YTD4, hair_YTD5, hair_YTD6, hair_YTD7, hair_YTD8]
print('TTL New Binding   {0[0]} (+{0[1]} vs L YTD)，New Binding Purchaser {0[2]} (+{0[3]} vs L YTD).'.format(hair_YTD_list))
print('TTL Binding rate {0[4]} (+{0[5]} vs L YTD)，New Binding rate {0[6]} (+{0[7]} vs L YTD)'.format(hair_YTD_list))
#最后要注意筛选出+-20%这样的形式
```
# brand health邮件生成
```python
filename1 = 'Brand Health Checking Report_ Men_202005.txt'
filename2 = 'Brand Health Checking Report_ Hair_202005.txt'
brand_health1 = pd.read_table(filename1, skiprows = 4)
brand_health2 = pd.read_table(filename2, skiprows = 4)
#skiprows = 4，删除前四行
brand_health1.drop(brand_health1.columns[0], axis=1, inplace=True)
brand_health2.drop(brand_health2.columns[0], axis=1, inplace=True)  
#删除第一列

man_r121 = brand_health1.loc[5]['Men']
man_r122 = brand_health1.loc[5]['Evol%']
man_r123 = brand_health1.loc[12]['Men']
man_r124 = brand_health1.loc[12]['Evol%']
man_r125 = brand_health1.loc[13]['Men']
man_r126 = brand_health1.loc[26]['Men']
man_r127 = brand_health1.loc[18]['Men']
man_r128 = brand_health1.loc[18]['Evol%']
man_r129 = brand_health1.loc[24]['Men']
man_r1210 = brand_health1.loc[24]['Evol%']
man_r1211 = brand_health1.loc[9]['Men']
man_r1212 = brand_health1.loc[9]['Evol%']
man_r1213 = brand_health1.loc[11]['Men']
man_r1214 = brand_health1.loc[11]['Evol%']

man_ytd1 = brand_health1.loc[5]['Men.1']
man_ytd2 = brand_health1.loc[5]['Evol%.1']
man_ytd3 = brand_health1.loc[12]['Men.1']
man_ytd4 = brand_health1.loc[12]['Evol%.1']
man_ytd5 = brand_health1.loc[13]['Men.1']
man_ytd6 = brand_health1.loc[26]['Men.1']
man_ytd7 = brand_health1.loc[18]['Men.1']
man_ytd8 = brand_health1.loc[18]['Evol%.1']
man_ytd9 = brand_health1.loc[24]['Men.1']
man_ytd10 = brand_health1.loc[24]['Evol%.1']
man_ytd11 = brand_health1.loc[9]['Men.1']
man_ytd12 = brand_health1.loc[9]['Evol%.1']
man_ytd13 = brand_health1.loc[11]['Men.1']
man_ytd14 = brand_health1.loc[11]['Evol%.1']

hair_r121 = brand_health2.loc[5]['Hair']
hair_r122 = brand_health2.loc[5]['Evol%']
hair_r123 = brand_health2.loc[12]['Hair']
hair_r124 = brand_health2.loc[12]['Evol%']
hair_r125 = brand_health2.loc[13]['Hair']
hair_r126 = brand_health2.loc[26]['Hair']
hair_r127 = brand_health2.loc[18]['Hair']
hair_r128 = brand_health2.loc[18]['Evol%']
hair_r129 = brand_health2.loc[24]['Hair']
hair_r1210 = brand_health2.loc[24]['Evol%']
hair_r1211 = brand_health2.loc[9]['Hair']
hair_r1212 = brand_health2.loc[9]['Evol%']
hair_r1213 = brand_health2.loc[11]['Hair']
hair_r1214 = brand_health2.loc[11]['Evol%']

hair_ytd1 = brand_health2.loc[5]['Hair.1']
hair_ytd2 = brand_health2.loc[5]['Evol%.1']
hair_ytd3 = brand_health2.loc[12]['Hair.1']
hair_ytd4 = brand_health2.loc[12]['Evol%.1']
hair_ytd5 = brand_health2.loc[13]['Hair.1']
hair_ytd6 = brand_health2.loc[26]['Hair.1']
hair_ytd7 = brand_health2.loc[18]['Hair.1']
hair_ytd8 = brand_health2.loc[18]['Evol%.1']
hair_ytd9 = brand_health2.loc[24]['Hair.1']
hair_ytd10 = brand_health2.loc[24]['Evol%.1']
hair_ytd11 = brand_health2.loc[9]['Hair.1']
hair_ytd12 = brand_health2.loc[9]['Evol%.1']
hair_ytd13 = brand_health2.loc[11]['Hair.1']
hair_ytd14 = brand_health2.loc[11]['Evol%.1']

man_r12_list = []
man_ytd_list = []
hair_r12_list = []
hair_ytd_list = []
for i in range(1,15):
    a = 'man_r12' + str(i)
    b = 'man_ytd' + str(i)
    c = 'hair_r12' + str(i)
    d = 'hair_ytd' + str(i)
    a = eval(a)
    b = eval(b)
    c = eval(c)
    d = eval(d)
    man_r12_list.append(a)
    man_ytd_list.append(b)
    hair_r12_list.append(c)
    hair_ytd_list.append(d)

#把取出的数加入list

print('\nMAN_R12\nTotal Purchaser {0[0]}K (+{0[1]} vs L R12). New Purchaser {0[2]}K (+{0[3]} vs L R12), {0[4]} of total Purchaser.'.format(man_r12_list))
print('Avg.age: {0[5]}'.format(man_r12_list))
print('New repeat rate {0[6]}, +{0[7]} vs L R12.'.format(man_r12_list))
print('Retention rate {0[8]}, +{0[9]} vs L R12.'.format(man_r12_list))
print('ATV {0[10]} RMB, +{0[11]} vs L R12.'.format(man_r12_list))
print('Annual Frequency {0[12]}, +{0[13]} vs L R12.'.format(man_r12_list))

print('\nMAN_YTD\nTotal Purchaser {0[0]}K (+{0[1]} vs LY). New Purchaser {0[2]}K (+{0[3]} vs LY), {0[4]} of total Purchaser.\nAvg.age: {0[5]}\nNew repeat rate {0[6]}, +{0[7]} vs LY.\nRetention rate {0[8]}, +{0[9]} vs LY.\nATV {0[10]} RMB, +{0[11]} vs LY.\nAnnual Frequency {0[12]}, +{0[13]} vs LY.'.format(man_ytd_list))
  
print('\nHAIR_R12\nTotal Purchaser {0[0]}K (+{0[1]} vs L R12). New Purchaser {0[2]}K (+{0[3]} vs L R12), {0[4]} of total Purchaser.\nAvg.age: {0[5]}\nNew repeat rate {0[6]}, +{0[7]} vs L R12.\nRetention rate {0[8]}, +{0[9]} vs L R12.\nATV {0[10]} RMB, +{0[11]} vs L R12.\nAnnual Frequency {0[12]}, +{0[13]} vs L R12.'.format(hair_r12_list))

print('\nHAIR_YTD\nTotal Purchaser {0[0]}K (+{0[1]} vs LY). New Purchaser {0[2]}K (+{0[3]} vs LY), {0[4]} of total Purchaser.\nAvg.age: {0[5]}\nNew repeat rate {0[6]}, +{0[7]} vs LY.\nRetention rate {0[8]}, +{0[9]} vs LY.\nATV {0[10]} RMB, +{0[11]} vs LY.\nAnnual Frequency {0[12]}, +{0[13]} vs LY.'.format(hair_ytd_list))
#最后要注意筛选出+-20%这样的形式,+0%,年月日
```
