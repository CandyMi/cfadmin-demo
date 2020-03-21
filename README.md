# 基于M-V-C模式的项目结构管理

  这是一份简单的项目规范文档介绍, 给使用[cf](https://github.com/CandyMi/core_framework)框架开发`web`项目做一个简单规范.

## 一、配置与入口

#### 1. main.lua

  `main.lua`通常做为入口文件.

#### 2. config.lua

  `config.lua`用来定义所有静态配置参数, 这些参数通常会在其它地方应用. 运行时请不要尝试修改它

## 二、Controllers

  `Controllers`文件夹通常存放所有编写好的路由.

#### 1. Controllers/Api

  `Api`文件夹内通常包含所有用`app:api`方法注册的接口路由.(具体使用方法参看内部文件示例)

#### 2. Controllers/View

  `View`文件夹内通常包含用户编写的页面路由, 其包含模板应该单独管理. 这里不做要求.(具体使用方法参看内部文件示例)

#### 3. Controllers/Admin

  `Admin`文件夹内通常包含所有后台管理页面相关路由.(具体使用方法参看内部文件示例)

#### 4. Controllers/Websocket

  `Websocket`文件夹内通常包含所有`Websocket`路由. (具体使用方法参看内部文件示例)

#### 5. 注意

  1. Api/View/Admin等路由会自动根据创建的文件注册`文件名即路由路径`的路由.

  2. 如果您对上述注册路由的方式有歧义, 可以在创建文件后指定相关属性来修改注册行为.

  3. 开发阶段为防止用户注册路由的歧义性, 可以使用`Controllers.dump`方法来打印已注册的路由.

  4. 使用`Controllers.all_init`方法可以一次性注册所有路由.

## 三、Model

  `Model`文件夹用于初始化与存放所有编写好的数据库查询方法.

#### 1. Model/init.lua

  `init.lua`用来初始化`Model`.

#### 2. Model/Sql

  `SQL`内用于存放用户自定义编写的查询方法, (具体使用方法可以参考`Models/Sql/user.lua`).

#### 3. 注意

  `Model`需要在Controllers注册之前完成初始化, 否则在Admin初始化的时候会抛出错误.


## 四、LICENSE

  [MIT License](https://github.com/CandyMi/cfadmin-demo/blob/master/LICENSE)