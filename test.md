```python
import pandas as pd
import numpy as np
from pandas import Series, DataFrame

filename = 'SKU-06010.txt'
sku_dataset = pd.read_table(filename)
sku_dataset
sku_dataset['CATEGORYCH'] = sku_dataset['CATEGORYCH'].apply(str)
#因为CATEGORYCH中存在空值，sku_dataset.CATEGORYCH.str.contains('彩妆')的操作实际上out的是布尔逻辑值，空值在sku_dataset[bool]会出错。所以先把CATEGORYCH空值也变成了字符串。
sku_dataset[~sku_dataset.CATEGORYCH.str.contains('彩妆')]

#这样就删除了CATEGORYCH是彩妆的行，其他同理
#最后还要导出到excel或csv
```
