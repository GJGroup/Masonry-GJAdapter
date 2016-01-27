# Masonry-GJAdapter
A adapter between 'Masonry' and 'layout of Interface Builder'.

- Masonry是一款老少皆宜，男女通吃的Autolayout封装库，封装了系统提供的繁琐的Autolayout接口，但他与Interface builder比的话，还是IB更加便捷与直观，但是为何这个类库还如此受欢迎呢？主要是他强大的update和remake功能，处理复杂动态页面时非常得心应手。

    > 我们通常在搭建界面的时候会考虑两套方案：
    
    > 1，对于静态页面，我们更偏向于storyboard或xib；
    
    > 2，对于动态页面，肯定是需要代码修改约束，所以通常我们会使用Masonry或者IBOutlet，使用Masonry的话，大量的静态页面布局又会没那么爽，使用IBOutlet的话，简单的constant修改还算轻松，但是遇到复杂的需要remake的时候，就变得非常恶心。
    
- Masonry的约束可以与系统约束共存，但无法update及remake系统约束，这就是我们使用Masonry时候的痛点，针对这个痛点，我们开发了一个Adapter，可以使Masonry对系统约束进行update及remake，极大的方便了复杂动态页面的搭建效率。
- 对于这种页面加入Adapter后的方案就是，使用storyboard或xib进行初始静态页面的搭建，可视而又便捷，在需要复杂动态变化的时候，在代码中直接用Masnory对其约束进行update及remake，很爽，不是么？


## 注意


像Masonry添加约束一样，当你有一个基于2个view之间的约束，在Masonry中的代码会是：

``` objc
        [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view1.mas_bottom).offset(100);
        }];
```

这段代码表明，你会添加一个view2的top到view1的bottom距离的约束，但是当你remake或者update的时候你必须这样写：

``` objc
        [self.view2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view1.mas_bottom).offset(200);
        }];
```

也就是说，你必须用view2来执行remake或update方法才可以，如果反过来则不行：

``` objc
        [self.view1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view2.mas_top).offset(200);
        }];
```

这样的话，之前的约束并没有删除，remake后会添加一条新的约束，导致冲突。


那么我们如何来确定IB中调用remake和update的那个view呢？其实，就是下图中的First Item中的view，图里显示view2是first itme，那么我们要用Masonry编辑这个约束的时候，就需要用view2来调用remake或update方法才会生效。
<img src="https://github.com/GJGroup/Masonry-GJAdapter/blob/master/ScreenShot/ss1.png" width="512">
