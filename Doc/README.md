
# 接口文档

## 依赖

  * `Nodejs`

  * `apidoc`

## 安装方式

  1. 安装`node`, `npm`.

  2. 使用`npm`安装`apidoc`: `npm install apidoc -g`

## 目录结构

  1. `apis`目录

  用于编写接口文档的目录 (具体编写方法参看内部文件示例)

  2. `doc`目录

  默认情况下不存在此目录. 运行`build.sh`后会自动生成.


## 使用指南

  1. 完善`apidoc.json`来完成文档概要信息初始化工作.

  2. 参考`apis`目录内的示例编写文档, 文档后缀必须为`.lua`.

  3. 运行`build.sh`文件, 它会根据`apis`目录下编写的文档来生成静态页面.

  4. 将`doc`下生成的静态页面拷贝到您的`web`服务器下查看.


## 其他

  更多高级使用方法, 请参考`apidoc`的[官方文档](https://apidocjs.com/)