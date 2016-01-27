# Masonry-GJAdapter
A adapter between 'Masonry' and 'layout of Interface Builder'.

- Masonry是一款老少皆宜，男女通吃的Autolayout封装库，封装了系统提供的繁琐的Autolayout接口，但他与Interface builder比的话，还是IB更加便捷与直观，但是为何这个类库还如此受欢迎呢？主要是他强大的update和remake功能，处理复杂动态页面时非常得心应手。

    > 我们通常在搭建界面的时候会考虑两套方案：
    
    > 1，对于静态页面，我们更偏向于storyboard或xib；
    
    > 2，对于动态页面，肯定是需要代码修改约束，所以通常我们会使用Masonry或者IBOutlet，使用Masonry的话，大量的静态页面布局又会没那么爽，使用IBOutlet的话，简单的constant修改还算轻松，但是遇到复杂的需要remake的时候，就变得非常恶心。
    
- Masonry的约束可以与系统约束共存，但无法update及remake系统约束，这就是我们使用Masonry时候的痛点，针对这个痛点，我们开发了一个Adapter，可以使Masonry对系统约束进行update及remake，极大的方便了复杂动态页面的搭建效率。
- 对于这种页面加入Adapter后的方案就是，使用storyboard或xib进行初始静态页面的搭建，可视而又便捷，在需要复杂动态变化的时候，在代码中直接用Masnory对其约束进行update及remake，很爽，不是么？


## 注意

<img src="httpshttps://github.com/GJGroup/Masonry-GJAdapter/blob/master/ScreenShot/ss1.png" width="512">

