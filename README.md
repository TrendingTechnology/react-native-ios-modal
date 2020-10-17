# react-native-ios-modal
A react-native component for displaying a modal on iOS by natively wrapping a react-native view inside a `UIViewController` and presenting it.
* Since this is just using a `UIViewController`, this component also supports setting the`UIModalPresentationStyle` and `UIModalTransitionStyle`.
* Supports setting `isModalInPresentation` and separately disabling the native swipe down gesture when the modal is using `pageSheet` `modalPresentationStyle`.
* You can use `ModalView` anywhere in your app and present a view modally either programmatically via a ref or automatically when a `ModalView` is mounted/unmounted.
* Support for several modal events, multiple modals, and having a transparent background or a blurred background using `UIBlurEffect`.
* **Note**:  Documentation Under Construction 🚧

![Modal Example 0 & 1](./assets/ModalExample-00-01.gif)

![Modal Example 2 & 3](./assets/ModalExample-02-03.gif)

![Modal Example 4 & 5](./assets/ModalExample-04-05.gif)

![Modal Example 6 & 7](./assets/ModalExample-06-07.gif)

### Motivation
* You can use this, but it's iOS only (so you have to use a different modal component on android). I just really liked the native iOS 13 `pageSheet` modal behavior, and iOS also  automatically handles the modal dismiss gesture when using a scrollview. 
* So this component exist to tap into native iOS modal behaviour. Ideally, another library will use this component (like a navigation library) to show modals and handle using a different component for android.
- - -
<br/><br/>

## 1. Installation

```sh
npm install react-native-ios-modal
```
- - -
<br/><br/>

## 2. Usage
Please check out the examples directory for more on how to use it.
```js
import { ModalView } from 'react-native-ios-modal';
```
- - -
<br/><br/>


## 3. Documentation
### 3.1 `ModalView` Component Props
#### 3.1.1 Props: Flags
| Name                            | Default | Description                                                  |
|---------------------------------|---------|--------------------------------------------------------------|
| presentViaMount                 | false   | If this prop is set to true, the modal will be presented or dismissed when the `ModalView` is mounted/unmounted. |
| isModalBGBlurred                | true    | Set whether or not the background is blurred. When true, `modalBGBlurEffectStyle` prop takes effect. |
| enableSwipeGesture              | true    | When the modal is using `pageSheet` or similar `modalPresentationStyle`, this prop controls the whether or not the swipe gesture is enabled. |
| hideNonVisibleModals            | true    | When multiple modals are visible at the same time, the first few modals will be temporarily hidden (they will still be mounted) to improve performance. |
| isModalBGTransparent            | true    | Sets whether or not the modal background is transparent. When set to false, the background blur effect will be disabled automatically. |
| isModalInPresentation           | false   | When set to true, it prevents the modal from being dismissed via a swipe gesture. |
| setEnableSwipeGestureFromProps  | false   | When set to true, it allows you to set the `enableSwipeGesture` via the `setEnableSwipeGesture` function. |
| setModalInPresentationFromProps | false   | When set to true, it allows you to set the`isModalInPresentation` via the `setIsModalInPresentation`function. |

<br/>

#### 3.1.2 Props: Strings
| Name                   | Default or Type                                              | Description                                                  |                                             |
|------------------------|--------------------------------------------------------------|--------------------------------------------------------------|---------------------------------------------|
| modalID                | **Default**: `null`                                          | Assign a unique ID to the modal. You can use the ID to refer to this modal when using the `ModalViewModule` functions and programatically control it.  | **Type**: String                            |
| modalTransitionStyle   | **Default**: `coverVertical`                                 | The transition style to use when presenting/dismissing a modal. | **Type**: `UIModalTransitionStyles` value   |
| modalPresentationStyle | **Default**: `automatic` when on iOS 13+, otherwise  `overFullScreen` | The presentation style to use when presenting/dismissing a modal. | **Type**: `UIModalPresentationStyles` value |
| modalBGBlurEffectStyle | **Default**: `systemThinMaterial` when on iOS 13+, otherwise  `regular` | The blur style to use for the `UIBlurEffect` modal background.  | **Type**: `UIBlurEffectStyles` value        |

<br/>

#### 3.1.3 Props: Modal Events
| Name                  | Description                                                  |
|-----------------------|--------------------------------------------------------------|
| onModalFocus          | Gets called when a modal is focused and is not currently the top most modal (to avoid duplicating the onModalShow event) |
| onModalBlur           | Gets called when a modal loses focus and is not currently the top most modal (to avoid duplicating the onModalDismiss event) |
| onModalShow           | Gets called after a modal is presented.                      |
| onModalDismiss        | Gets called after a modal is dismissed.                      |
| onModalDidDismiss     | Gets called after a modal is successfully dismissed via a swipe gesture. (Wrapper for `UIAdaptivePresentationControllerDelegate.presentationControllerDidDismiss`). |
| onModalWillDismiss    | Gets called when a modal is being swiped down via a gesture. ((Wrapper for  `UIAdaptivePresentationControllerDelegate.presentationControllerWillDismiss`). |
| onModalAttemptDismiss | Gets called when a modal is swiped down when `isModalInPresentation` is true. (Uses `UIAdaptivePresentationControllerDelegate.presentationControllerDidAttemptToDismiss`). |

<br/>

####  3.1.4 Props: Modal Functions
| Name                                 | Description                                                  |
|--------------------------------------|--------------------------------------------------------------|
| getEmitterRef                        | Gets a ref to the `EventEmitter` instance.                   |
| **aysnc** - setVisibility            | Programatically present/dismiss the modal. Resolved after the modal is presented/dismissed. |
| **aysnc** - setEnableSwipeGesture    | When `setEnableSwipeGestureFromProps` prop is true, it allows you to programatically set `enableSwipeGesture` prop via a function. |
| **async** - setIsModalInPresentation | When `setModalInPresentationFromProps` prop is true, it allows you to programatically set  `isModalInPresentation` via function. |
<br/>

### 3.2 `ModalViewModule`
* `async ModalViewModule.dismissModalByID(modalID: string)`
* `async dismissAllModals(animated: bool)`

<br/>

### 3.3 Enum Values
#### 3.3.1 UIBlurEffectStyles 
Enum values that you can pass to the `ModalView` `modalBGBlurEffectStyle` prop. More detailed description are available in the [Apple Developer Docs](https://developer.apple.com/documentation/uikit/uiblureffectstyle).
* Import the enum like this: `import { UIBlurEffectStyles } from 'react-native-ios-modal'`.
* And use the enum in the `ModalView` component `modalBGBlurEffectStyle` prop like this: `modalBGBlurEffectStyle={UIBlurEffectStyles.systemMaterial}`.
* Or if you prefer, just pass in a string value directly like this: `modalBGBlurEffectStyle={'systemMaterial'}`.

<br/>

* **Adaptable Styles** — Requires iOS 13 and above. Changes based on the current system appearance)
1. `systemUltraThinMaterial`
2. `systemThinMaterial`
3. `systemMaterial`
4. `systemThickMaterial`
5. `systemChromeMaterial`

<br/>

* **Light Styles** — Requires iOS 13. Blur styles that are tinted white/light. Meant to be used for system light appearance.
1. `systemMaterialLight`
2. `systemThinMaterialLight`
3. `systemUltraThinMaterialLight`
4. `systemThickMaterialLight`
5. `systemChromeMaterialLight`

<br/>

* **Dark Styles** — Requires iOS 13. Blur styles that are tinted black/dark. Meant to be used for system dark appearance.
1. `systemChromeMaterialDark`
2. `systemMaterialDark`
3. `systemThickMaterialDark`
4. `systemThinMaterialDark`
5. `systemUltraThinMaterialDark`

<br/>

* **Regular Styles** — Blur styles that were originally added in iOS 8.
1. `regular`
2. `prominent`
3. `light`
4. `extraLight`
5. `dark`

<br/>

#### 3.3.2 UIModalPresentationStyles 
Enum values that you can pass to the `ModalView` `modalPresentationStyle` prop. More detailed description are available in the [Apple Developer Docs](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle).
* Import the enum like this: `import { UIModalPresentationStyles } from 'react-native-ios-modal'`.
* And use the enum in the `ModalView` component `modalPresentationStyle` prop like this: `modalPresentationStyle={UIModalPresentationStyles.fullScreen}`.

<br/>

* **Supported Presentation Styles**
1. `automatic` — Requires iOS 13 to work. The default presentation style for iOS 13 and above.
2. `fullScreen` — Present fullscreen but with an opaque background. The default presentation style on iOS 12 and below.
3. `overFullScreen` — Present fullscreen but with a transparent background.
4. `pageSheet` — The presentation style used on iPhones running iOS 13. Present a modal that can be dismissed via a swipe gesture.    
5. `formSheet` — The presentation style used on iPads. Same as `pageSheet` when on iPhone.

<br/>

* **Not Supported**
1. `none`
2. `currentContext`
3. `custom`
4. `overCurrentContext`
5. `popover`
6. `blurOverFullScreen`

<br/>

#### 3.3.3 UIModalTransitionStyles 

<br/>

#### 3.3.4 ModalEventKeys 

<br/>

### 3.4 `ModalContext`

<br/>

### 3.5 `withModalLifecycle`

<br/>

### 3.6 Modal `EventEmitter`

<br/>

### 3.7 Modal `NativeEvent` object

<br/><br/>


## License

MIT
