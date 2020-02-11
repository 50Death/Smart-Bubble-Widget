# Smart Bubble Widget
[English Version]()
一个可自适应大小的聊天气泡Flutter组件

## 实现原理

气泡由背景(气泡本身)和内容(child)组成，当一起渲染时，无法得知内容所占大小，所以没法在第一次渲染时让气泡和内容正好合适。
这里使用完成状态监听，配合GlobalKey获取child组件渲染后的大小，从而再次调整气泡大小，从而使得气泡可以跟随内部元素进行自适应。

当组件initState时，对完成状态添加监听器：
```dart
  @override
  void initState() {
    super.initState();
    _widgetsBinding = WidgetsBinding.instance;
    _widgetsBinding.addPostFrameCallback((callback) {
      RenderObject object = _key.currentContext.findRenderObject();
      Size mSize = object.semanticBounds.size;
      _superSetState(() {
        height = mSize.height + padding.vertical;
        width = mSize.width + padding.horizontal;
      });
    });
  }

    void _superSetState(callback) {
    setState(() {
      callback();
    });
  }
```
当组件第一次build结束后，内部元素child已有确定的大小，内部对child使用了OverflowBox进行包裹，使内部元素可以超出外部组件，从而使比如Text()组件能够正常伸展，无法伸展了再回行。
```dart
child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width - 70,
                      child: Container(
                        child: this.child,
                        key: _key,
                      ),
                    )
```
简言之，就是对build进行监听，build完成后获取内部组件大小，然后setState()更改外部气泡大小以适应。

## 参数
maxWidth → double
最大宽度，第一次渲染时气泡的宽度，内部OverFlowBox限制了child最大不能超过屏幕宽度-70，设置过小会导致内部元素超出宽度，导致部分不可见。可设的非常大不会布局溢出。用户无法看到第一次渲染时非常大的气泡。
默认值： 200.0

maxHeight → double
最大高度，第一次渲染时气泡的高度，设置过小会导致下方超出布局的内容不可见，可设置非常大不会布局溢出。用户无法看到第一次渲染时非常大的气泡。
默认值：2048.0

color → Color
气泡颜色
默认值：蓝色Colors.blue

borderColor → Color
边框颜色
可缺省

arrowDirection → ArrowDirection
气泡箭头方向
可选值：左(ArrowDirection.left)，右(ArrowDirection.right)
默认值ArrowDirection.right

child → Widget
子元素，已测试过图片和文字

title → Text
气泡标题，气泡上方的文字
可缺省

padding → EdgeInsets
气泡到内部组件的距离
默认值EdgeInsets.symmetric(horizontal: 20, vertical: 15)

其他参数请参考[内部气泡原作者](https://www.jianshu.com/p/2eb98bc08078)

## 使用样例
```dart
SmartBubble(
    title: Text("192.168.31.1"),
    arrowDirection: ArrowDirection.left,
    child: Text("Hello",style: TextStyle(color: Colors.white, fontSize: 30)),
),
SmartBubble(
    title: Text("192.168.31.1"),
    child: Image.asset("assets/3.png")
),
```

## 截图
![截图]()
<img src="https://github.com/50Death/Smart-Bubble-Widget/blob/master/screenshots/Screenshot_20200211-171136.jpg" width = "144" height = "304" alt="截图" 
align=center>
## 引用
使用了StevenHu_Sir的不能自适应大小的气泡
[点此跳转](https://www.jianshu.com/p/2eb98bc08078)，并在此基础上新增了自适应大小和左上方箭头

## English
An auto-fit chat bubble of Flutter Widget

## How it work
Bubble contains bubble itself and its child. When widget rending as build(). We can not know the size of the child. So we use a listener to callback when build() is finished. After build(), we measure child and resize the bubble. We use GlobalKey() to get child size. Use WidgetsBinding to callback.

When initState(), add complete build() listener.
```dart
  @override
  void initState() {
    super.initState();
    _widgetsBinding = WidgetsBinding.instance;
    _widgetsBinding.addPostFrameCallback((callback) {
      RenderObject object = _key.currentContext.findRenderObject();
      Size mSize = object.semanticBounds.size;
      _superSetState(() {
        height = mSize.height + padding.vertical;
        width = mSize.width + padding.horizontal;
      });
    });
  }

    void _superSetState(callback) {
    setState(() {
      callback();
    });
  }
```

After first build, we can now get the size of the child. Since the child is wrapped by OverflowBox() so it will auto expand to a comfort size. Especially useful when child is Text. It will expand horizontally to the max then expand vertically.
```dart
child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width - 70,
                      child: Container(
                        child: this.child,
                        key: _key,
                      ),
                    )
```

## Params
maxWidth → double
Max width. the bubble width when first render. No negative effect when set a large number. But will cause part of child hidden when set a small number. Inside OverflowBox() is set maxWidth so it's ok to set a very large number if you want to expand max. User will NOT see the large bubble when first render.
Default: 200.0

maxHeight → double
Max height. the bubble height when first render. No negative effect when set a large number. But will cause part of child hidden when set a small number. User will NOT see the large bubble when first render.

color → Color
Bubble's color
Default: Colors.blue

borderColor → Color
Bubble's border color
can be null

arrowDirection → ArrowDirection
Direction of the bubble's arrow.
Options: ArrowDirection.left, ArrowDirection.right
Default: ArrowDirection.right

child → Widget
child widget. had tested picture and Text

title → Text
Title of the Bubble
can be null

Other params please refer to the original bubble's author.

## Example
```dart
SmartBubble(
    title: Text("192.168.31.1"),
    arrowDirection: ArrowDirection.left,
    child: Text("Hello",style: TextStyle(color: Colors.white, fontSize: 30)),
),
SmartBubble(
    title: Text("192.168.31.1"),
    child: Image.asset("assets/3.png")
),
```

## Reference
Used StevenHu_Sir's NO AUTO-FIT Bubble
[Click here](https://www.jianshu.com/p/2eb98bc08078), and add left top arrow and auto-fit function.
