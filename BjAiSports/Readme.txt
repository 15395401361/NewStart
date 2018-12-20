这是项目介绍
项目模块划分
1.Appdelegate  文件夹，放置appdelegate 相关的文件。
2.General 文件夹，这个目录是一个核心目录，整个项目的目录划分在这个主目录中。（Libs（用到的非pod管理的第三方库），Category（分类），Modules（项目的所有模块），Macro（基本的配置， 比如网络，基类）。）
3.Macro目录完善，Public （放置一些pch 文件，宏管理，通知管理等全局头文件所在位置）,MainArchitecture (放置项目的导航Navigation和菜单栏TabBar),NetWorkEngine （放置网络的工具类，网络的二次间接封装.）MVC （中放置一些项目的BaseController ， BaseModel，baseCell,BaseView） 等。父类。
4.Modules 目录完善,项目的核心业务成。内部按照功能模块划分。主要是根据模块来区分, 然后在某个某个某块中以MVC的设计模式来做细化的区分。
5.第三方，使用CocoaPods来管理第三方代码。如果项目中已经有了cocoaPods 导入的三方库，在不知道别人是否对三方库进行更改的情况下，pod Install 或者 pod update 后面一点要添加 -verbose --no-repo-update ,放置别人手动更改的三方库受到影响。
