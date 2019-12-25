window.addEventListener('message', eventHandler, false)

function eventHandler(event) {
    alert(event.data);
}

function callFlutter() {
    // var event = new CustomEvent('JSEvent', {'detail': 'this is JS!'});
    // parent.dispatchEvent(event);
    //跨iframe传递消息需要使用parent
    parent.postMessage('this is js message', '*');
}


const eventList = [
    'onContentReady', // 内容准备好(不包括图片)
    'onEditorRendered', // 编辑器渲染完毕
    'onRequestResources', // 请求资源
    'onContentRendered', // 所有内容准备完毕
    'onEditorFocused', // 编辑器失去/获取焦点
    'onReceiveEditorContent', // 返回编辑器内容
    'onOpenLink' // 打开链接
]
eventList.forEach((e) => {
    window[e] = (arg) => {
        console.log(e)
        parent.postMessage(JSON.stringify({
            event:e,
            param:'11111'
        }),"*");
        console.log(e)
    }
})

window.addEventListener('message', (message) => {
    var jsonData = JSON.parse(message.data);
    console.log(jsonData)
    if (eventList.indexOf(jsonData.event) === -1) {
        console.log(message)
        window[jsonData.event](jsonData.param);
        console.log(message)
    }
})