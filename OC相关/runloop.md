# runloop 有几种模式？
模式包括：

default模式：几乎包括所有输入源(除NSConnection) NSDefaultRunLoopMode模式

mode模式：处理modal panels

connection模式：处理NSConnection事件，属于系统内部，用户基本不用

event tracking模式：如组件拖动输入源 UITrackingRunLoopModes 不处理定时事件

common modes模式：NSRunLoopCommonModes 这是一组可配置的通用模式。将input sources与该模式关联则同时也将input sources与该组中的其它模式进行了关联。

