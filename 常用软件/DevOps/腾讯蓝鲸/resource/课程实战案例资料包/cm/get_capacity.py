# -*- coding: utf-8 -*-
"""
Copyright © 2012-2018 Tencent BlueKing. All Rights Reserved. 蓝鲸智云 版权所有
"""
from django import forms

from common.forms import BaseComponentForm
from common.constants import API_TYPE_Q
from components.component import Component
from .toolkit import configs


class GetCapacity(Component):
    """
        apiLabel 磁盘容量查询
        apiMehtod GET

        ### 功能描述

        磁盘容量查询

        ### 请求参数

        {{ common_args_desc }}

        #### 接口参数

        | 字段  |  类型 | 必选   |  描述     |
        |-----------|------------|--------|------------|
        | token  |  string    | 是  | 合法性认证  |
        | ip  |  string    | 否  | 机器IP  |
        | filesystem  |  string    | 否  | filesystem  |
        | mounted  |  string    | 否  | mounted  |


        ### 请求参数示例

        ```python
        {
            "bk_app_code": "esb_test",
            "bk_app_secret": "xxx",
            "bk_token": "xxx-xxx-xxx-xxx-xxx",
            "token": "xxx",
            "ip": "1.1.1.1",
            "filesystem": "/dev/vdb1",
            "mounted": "/data"
        }
        ```

        ### 返回结果示例

        ```python
        {
            "result": true,
            "data": [{
                "ip": "1.1.1.1",
                "filesystem": "/dev",
                "mounted": "/data",
                "use": "20%",
                "createtime": "2018-1-1 10:10:10"
            }]
        }
        ```
        """
    sys_name = configs.SYSTEM_NAME
    api_type = API_TYPE_Q

    class Form(BaseComponentForm):
        token = forms.CharField(label='token', required=True)
        ip = forms.CharField(label='IP', required=False)
        filesystem = forms.CharField(label='filesystem', required=False)
        mounted = forms.CharField(label='mounted', required=False)

        def clean(self):
            data = self.cleaned_data
            return {
                'token': data['token'],
                'ip': data['ip'],
                'filesystem': data['filesystem'],
                'mounted': data['mounted']
            }

    def handle(self):
        # 获取Form clean处理后的数据
        data = self.form_data

        # 请求系统接口
        response = self.outgoing.http_client.get(
            host=configs.host,
            path='',   ## SaaS应用提供的正式环境接口 
            # data=json.dumps(data), #POST参数 
            params=data, #GET参数
        )

        # 对结果进行处理
        result = {
            'result': response['result'], 
            'data': response['data'],
            'message': response['message'],
        }
        # 设置组件返回结果，payload为组件实际返回结果
        self.response.payload = result
