## Introduction

Hi, Humans!

My name is Hamza Farooq and I love 'Swift' programming. I always try to implement new ideas. Do check [Swift-TopViewController](https://github.com/hamza-faroooq/Swift-TopViewController) for this CustomAlertManager to work

# Swift-CustomAlertManager
This class is used to make custom alert

### Images
![](Screenshots/SingleButtonAlert.png)
![](Screenshots/DoubleButtonAlert.png)

## Simple Usage

Do the following simple steps to add the Manager class in your project and present this CustomAlert

First of all follow this link to add the [Swift-TopViewController](https://github.com/hamza-faroooq/Swift-TopViewController) in your project. Because this file is used to present this ActionSheet

Then, simply download or copy [this](https://github.com/hamza-faroooq/Swift-CustomAlertManager/blob/main/CustomAlertManager.swift) code and place it in your project. (Click on the link, this will take you to the directory where extension is placed)

If you do not want to add [Swift-TopViewController](https://github.com/hamza-faroooq/Swift-TopViewController) in your project. then you can modify [CustomAlertManager](https://github.com/hamza-faroooq/Swift-CustomAlertManager/blob/main/CustomAlertManager.swift) on your on

## Example

### Single button usage with no callback

```swift

AlertManager.customAlertView(messageString: "Enter Valid Email")

```

### Single button usage with callback

```swift

AlertManager.customAlertView(messageString: "A reset password link has been sent to the given email address", isDismissingDialogForFirstButton: false, leftButtonCallBack: {
    
    AlertManager.topVCGeneric.view.viewWithTag(100)?.removeFromSuperview()
    AlertManager.topVCGeneric.view.viewWithTag(200)?.removeFromSuperview()
    
    // do your stuff here

})

```

One thing is to keep in mind is when *isDismissingDialogForFirstButton* is set to *false* and you used the callback method, then you have to remove alert manually from your callback function like above

### Double button usage with only first button callback

```swift

AlertManager.customAlertView(messageString: "Are you sure to logout?", isSingleButton: false, leftButtonTitle: "Yes", rightButtonTitle: "No", isDismissingDialogForFirstButton: false, leftButtonCallBack: {

        AlertManager.topVCGeneric.view.viewWithTag(100)?.removeFromSuperview()
        AlertManager.topVCGeneric.view.viewWithTag(200)?.removeFromSuperview()
        
        // do your stuff here
        
})

```

Play with the variables available to achieve more results

## Contributions

Your contributions are most welcomed. Do let me know if you find any kind of issue while using this file. Please open an issue to discuss that problem. Thanks

## Auther

Hamza Farooq, hamza_faroooq@yahoo.com

## License

[MIT](https://github.com/hamza-faroooq/Swift-CustomAlertManager/blob/main/LICENSE) (Click Me O_o)
