```python
#-*- coding:utf-8 -*-
import pandas as pd
from pandas import Series, DataFrame
#为了方便，在运行前先把SKU LOCALNAME改成SKU_LOCALNAME（sku表）, SKU CODE改成SKU_CODE(两张表)

filename = 'SKU-06010.txt'
sku_dataset = pd.read_table(filename)
filename2 = '资料_商品整理表test.txt'
sku_zl = pd.read_table(filename2)
#打开sku表和整理表

zl_code = list(sku_zl['SKU_CODE'])
sku_dataset = sku_dataset[~sku_dataset.SKU_CODE.isin(zl_code)]
sku_dataset
#删除整理表中已有的sku code
sku_dataset['CATEGORYCH'] = sku_dataset['CATEGORYCH'].apply(str)
sku_dataset = sku_dataset[~sku_dataset.CATEGORYCH.str.contains('彩妆|脸部护理')]
sku_dataset['SKU_LOCALNAME'] = sku_dataset['SKU_LOCALNAME'].apply(str)
sku_dataset = sku_dataset[~sku_dataset.SKU_LOCALNAME.str.contains('随机|换购|葡萄籽|玻尿酸|券|肌底液|紧肤水|卸妆|海报|腮红|睫毛|眼线|眼影|眉笔|档|化妆|青春密码|唇膏|唇釉|唇彩|唇线笔|甲油|美甲|粉饼|遮瑕|粉底|白护|自由来|沁润|凝养|雪颜|纤体|清润|眉笔|恒放|魅力|风盈|清盈|盈爽|时尚珍藏')]
#删除不需要的类别和关键词

sku_dataset.to_csv(path_or_buf = r'C:\Users\mye\Desktop\jupyter\test.csv', encoding="utf_8_sig")
#导出为csv
```
