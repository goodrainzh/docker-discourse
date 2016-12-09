**论坛**（BBS Bulletin Board System）这个听起来貌似是上个世纪发明出来的玩意，在现如今众多的社交工具和信息平台中已经没什么人提到它了。但真实情况并不是这样，随着社会进步论坛也升级了，变成了其他的形式为我们提供服务。像App中的 `社区`、`讨论`、`发现` 等模块还能够找到论坛的影子，只是他们的名字和表现形式更符合我们现在的使用习惯而已。

那传统的论坛是不是真的消失了呢？我在国内调研了一圈，发现传统论坛也升级了，他们的界面简洁、操作简单，在国内仍有很大的用户群体。今天为大家介绍的论坛系统和国内那些社区都不太一样，它号称为互联网下一个十年打造的论坛系统。下面开始进入正题：



<div><a href="http://app.goodrain.com/detail/56/" target="_blank"><img src="https://t.goodrain.com/uploads/default/original/1X/f2e29684729cbf263ba99e87066cb7cd868dceff.png" width="147" height="32"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a href="https://github.com/goodrain-apps/docker-discourse" title="源码"><img src="https://t.goodrain.com/uploads/default/original/1X/e6c4975eae4bb78bf16cb11d268d3d2f4e28b881.png" width="25" height="25"></a>
</div>



# Discourse 是什么？
Discourse 是为今后 10 年的互联网打造的 100% 开放源代码的讨论平台。它可以用作：

- 邮件列表
- 论坛
- 聊天室

# Discourse 从哪来？
Discourse 是由 Stack Overflow 的联合创始人 Jeff Atwood 于2013年推出的下一代开源论坛系统。

# Discourse 的技术栈
基于 Ruby on Rails 和 Ember.js 开发，数据库使用 PostgreSQL 和 Redis

- Ruby on Rails — 后端服务和API接口服务。支持 RESTfully in JSON.
- Ember.js — 前端是Ember.js 应用，负责与后端 Rails API 通讯
- PostgreSQL — 程序的主要数据存储在PostgreSQL 数据库库中
- Redis — Redis作为缓存服务，存储临时的数据

# Discourse 有什么不同？
## 100% 开源
Discourse 是全新打造的，力图打造一个现代的、可持续的并且完全开放源代码的互联网讨论平台。它的设计非常的前卫 —— 无论是从技术角度还是从社会学的角度上。

## 智能
论坛的信誉系统为社群建立了一个免疫系统，用于防范骚扰、捣乱的人以及五毛党 —— 并且热心地社群成员能帮助一起管理他们自己的社群。 我们设计了简单和易用的标记系统，就像是在每条街的角落放上了垃圾桶。积极地行为可以通过赞和徽章来鼓励。 我们友善地并不断地用适时出现的提醒来教育用户文明讨论的通用法则。

## 简洁、现代、有趣
讨论话题应该是轻松有趣的，不应该是交错复杂的行为。论坛应该是面对个人的，不应该把屏幕上所有的内容都推给用户，应该只显示自己喜好的或者关注的话题。这些独具特色的功能Discourse都做到了。


# Discourse 的特性
## 话题 无需翻页
为什么要把话题内容分割到不同的页面，让我们不停的点“下一页”、“首页”、“尾页”…… 有没有想到大家都开始用手指头替代鼠标了。Discourse 利用动态加载技术让你一次看个够，只要你愿意，内容足够长，一直滚下去吧。

<img src="https://t.goodrain.com/uploads/default/original/1X/9b91b8e91b16d495f388a8d31bbb5ffa370f7295.gif" width="690" height="220">

## 动态提醒
当有人引用了你的帖子，系统会立马通知你。当有人@你，也会收到消息。当有人回复你的帖子时……好吧，我猜你已经知道会发生什么了。并且当你不常在论坛逛时，我们会通过邮件通知你，当然这些功能是可以自定义设置的。
<img src="https://t.goodrain.com/uploads/default/original/1X/6199f7e7c4be78bc3fcaf4f5d7d3604fe5a0616e.gif" width="690" height="220">

## 简洁但不遗漏
Discourse 是一个简洁、平面化的论坛，回复就像瀑布流一样线性的显示在页面中。回复可以展开，它们位于帖子的底部或顶部，以便您了解对话的完整上下文，这样也不用打断你的阅读。

<img src="https://t.goodrain.com/uploads/default/original/1X/993b0c3b993258a5210483f65978a1d0da34d95c.gif" width="690" height="220">

## 原生移动/触屏设备支持
Discourse 从开发的第一天起便为高分辨率的触摸设备设计，并且內建了一个为移动设备而设计的布局页面。无论是使用笔记本、平板或者智能手机访问论坛，都可以完美显示，也不会提示您切换不同的页面。

<img src="https://t.goodrain.com/uploads/default/original/1X/29218ead6a76309f7178d9fc635688bd31bede31.png" width="343" height="500">

## 自动显示链接信息
想要分享东西？直接粘贴链接地址，系统会自动显示关于链接的详细信息。链接至维基百科、YouTube、亚马逊、GitHub、Twitter、Flickr 和其他流行的网站就会自动显示扩展信息面板。（这项功能在国内支持得不太好）

<img src="https://t.goodrain.com/uploads/default/original/1X/9ba8fe9cf17fb59933ccdf667924a0fb2f478067.gif" width="690" height="328">

## 阅读时可回复
在阅读的时候，就可以写回复内容，这个回复的输入框是在浏览器最下面以浮动的形式出现的。当然还可以在浏览主题的过程中修改您的回复并引用更多内容！甚至可以在不同主题之间切换而无需担心编辑的内容丢失。

我们会保存您阅读的进度以及您帖子的草稿，即使你使用了不同的设备也可以记录这些信息。

<img src="https://t.goodrain.com/uploads/default/original/1X/8a284cac8e85c46aa6005f9fa6f03d3e2f33dba8.gif" width="690" height="328">

### 实时更新
当您在阅读或者回复主题时有新帖发起，或者有新的回复，系统会自动出现在页面中，并且以淡蓝色的颜色标识出来。

<img src="https://t.goodrain.com/uploads/default/original/1X/9533a80204493bf951213421ab04bd2d0ace4180.gif" width="690" height="328">

## 支持Markdown
这个就不必多说了，业界论坛和blog现在支持的都很好了

## 多语言支持
这个也需要重点提一下，使用国外的软件，本地化很重要。Discourse对中文支持的比较好，同时还支持除中国外的十几种语言。

## 更多
还要很多特性就不一一列举了，大家有兴趣可以参考 [官方介绍](https://www.discourse.org/about/)

# 安装
提到安装不得不吐槽一下，官方只提供了Docker的安装方式，除此之前的任何安装方式都要自己解决。从国外到国内，这个安装都是个问题。且不说Docker有没有人听说过，Docker的学习成本也很高，再加上咱们中国特色的网络条件那就更是难上加难了。这可能也是Discourse还没有在国内火起来的原因吧。看官别急，下文会提到一些解决方案。

# 试一试？
## 演示demo
- [官网Demo](https://meta.discourse.org/)
- [好雨云市](http://app.goodrain.com/detail/56/)
- [国内中文Demo](https://meta.discoursecn.org/)

## 一键部署私有Discourse服务
上文吐槽了安装方式，为了分享Discourse这个开源又好用的论坛系统，好雨云市提供了Discourse 应用，直接在 [云市页面](http://app.goodrain.com/detail/56/) 安装即可。分分钟搞定Discourse安装，不需要购买主机，也不需要学习Docker。

# 参考资料
- [好雨云市Discourse应用Dockerfile源码](https://github.com/goodrain-apps/docker-discourse)
- http://www.discoursecn.org/
- http://36kr.com/p/201256.html
- https://www.zhihu.com/question/20782489
