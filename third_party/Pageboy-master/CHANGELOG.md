# Change Log
All notable changes to this project will be documented in this file.
`Pageboy` adheres to [Semantic Versioning](https://semver.org/).

#### 3.x Releases
- `3.5.x` Releases - [3.5.0](#350)
- `3.4.x` Releases - [3.4.0](#340)
- `3.3.x` Releases - [3.3.0](#330)
- `3.2.x` Releases - [3.2.0](#320) | [3.2.1](#321) | [3.2.2](#322) | [3.2.3](#323)
- `3.1.x` Releases - [3.1.0](#310)
- `3.0.x` Releases - [3.0.0](#300) | [3.0.1](#301) | [3.0.2](#302) | [3.0.3](#303) | [3.0.4](#304) | [3.0.5](#305) | [3.0.6](#306) | [3.0.7](#307)

#### 2.x Releases
- `2.6.x` Releases - [2.6.0](#260) | [2.6.1](#261)
- `2.5.x` Releases - [2.5.0](#250) | [2.5.1](#251) | [2.5.2](#252) | [2.5.3](#253) | [2.5.4](#254)
- `2.4.x` Releases - [2.4.0](#240)
- `2.3.x` Releases - [2.3.0](#230) | [2.3.1](#231) | [2.3.2](#232) | [2.3.3](#233) | [2.3.4](#234)
- `2.2.x` Releases - [2.2.0](#220)
- `2.1.x` Releases - [2.1.0](#210)
- `2.0.x` Releases - [2.0.0](#200) | [2.0.1](#201) | [2.0.2](#202) | [2.0.3](#203) | [2.0.4](#204)

#### 1.x Releases
- `1.4.x` Releases - [1.4.0](#140) | [1.4.1](#141)
- `1.3.x` Releases - [1.3.0](#130) | [1.3.1](#131) | [1.3.2](#132) | [1.3.3](#133)
- `1.2.x` Releases - [1.2.0](#120) | [1.2.1](#121)
- `1.1.x` Releases - [1.1.0](#110) | [1.1.1](#111) | [1.1.2](#112)
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102) | [1.0.3](#103) | [1.0.4](#104) | [1.0.5](#105) | [1.0.6](#106) | [1.0.7](#107) | [1.0.8](#108) | [1.0.9](#109)

#### 0.x Releases
- `0.4.x` Releases - [0.4.0](#040) | [0.4.1](#041) | [0.4.2](#042) | [0.4.3](#043) | [0.4.4](#044) | [0.4.5](#045) | [0.4.6](#046) | [0.4.7](#047) | [0.4.8](#048) | [0.4.9](#049) | [0.4.10](#0410) | [0.4.11](#0411) | [0.4.12](#0412)

---
## [3.5.0](https://github.com/uias/Pageboy/releases/tag/3.5.0)
Released on 2019-10-06

#### Added
- [#230](https://github.com/uias/Pageboy/pull/230) `didCancelScrollToPage` function to `PageboyViewControllerDelegate` for detecting page transitions that were cancelled.
     - by [ChristianSteffens](https://github.com/ChristianSteffens)

#### Fixed
- [#227](https://github.com/uias/Pageboy/pull/227) `UIPageViewController` bug that causes the page view controller to display the wrong page ([see here](https://stackoverflow.com/questions/12939280/uipageviewcontroller-navigates-to-wrong-page-with-scroll-transition-style)).
     - by [ahmedk92](https://github.com/ahmedk92)

---
## [3.4.0](https://github.com/uias/Pageboy/releases/tag/3.4.0)
Released on 2019-08-25

#### Updated
- Add support for Swift Package Manager in Xcode 11.

---
## [3.3.0](https://github.com/uias/Pageboy/releases/tag/3.3.0)
Released on 2019-08-05

#### Added
- [#223](https://github.com/uias/Pageboy/pull/223) `minimumNumberOfTouches` to `PageboyViewController`.
     - by [ChristianSteffens](https://github.com/ChristianSteffens)
- [#223](https://github.com/uias/Pageboy/pull/223) `maximumNumberOfTouches` to `PageboyViewController`.
     - by [ChristianSteffens](https://github.com/ChristianSteffens)

#### Fixed
- Issues with building on tvOS.
- Broken imports when building with Carthage.

---
## [3.2.3](https://github.com/uias/Pageboy/releases/tag/3.2.3)
Released on 2019-06-10

#### Updated
- Added support for multiple Swift versions to podspec.

## [3.2.2](https://github.com/uias/Pageboy/releases/tag/3.2.2)
Released on 2019-05-04

#### Fixed
- [#209](https://github.com/uias/Pageboy/issues/209) Issue where pages could not be added when no pages exist.
- [#208](https://github.com/uias/Pageboy/issues/208) Issue where the last page could not be deleted.

## [3.2.1](https://github.com/uias/Pageboy/releases/tag/3.2.1)
Released on 2019-04-24

#### Fixed
- Warnings related to Objective-C enums.
     - by [Coeur](https://github.com/Coeur)
- SwiftLint warnings.
     - by [Coeur](https://github.com/Coeur)
- Incorrect Swift version in Podspec, now `4.0`.

## [3.2.0](https://github.com/uias/Pageboy/releases/tag/3.2.0)
Released on 2019-03-26

#### Added
- Swift 5 support.
- Xcode 10.2 support.

---
## [3.1.0](https://github.com/uias/Pageboy/releases/tag/3.1.0)
Released on 2019-03-08

#### Added
- `pageboyParent` to `UIViewController` to get the parent `PageboyViewController` if it exists.
- `pageboyPageIndex` to `UIViewController` to get the current index of a view controller if embedded within a `PageboyViewController`.

#### Updated
- Deprecated `parentPageboy` on `UIViewController`.

---
## [3.0.7](https://github.com/uias/Pageboy/releases/tag/3.0.7)
Released on 2019-03-03

#### Fixed
- [#202](https://github.com/uias/Pageboy/issues/202) Issue where page index map could crash with invalid keys (Relates to [#198](https://github.com/uias/Pageboy/issues/198)).

## [3.0.6](https://github.com/uias/Pageboy/releases/tag/3.0.6)
Released on 2019-03-03

#### Fixed
- [#198](https://github.com/uias/Pageboy/issues/198) Memory issue where view controllers would always be retained.

## [3.0.5](https://github.com/uias/Pageboy/releases/tag/3.0.5)
Released on 2019-02-22

#### Updated
- [#196](https://github.com/uias/Pageboy/pull/196) Improved extension access controls.
     - by [Coeur](https://github.com/Coeur)

## [3.0.4](https://github.com/uias/Pageboy/releases/tag/3.0.4)
Released on 2019-02-17

#### Fixed
- [#195](https://github.com/uias/Pageboy/pull/195) Ensure view controller update work is performed synchronously on the main thread.
     - by [remirobert](https://github.com/remirobert)

## [3.0.3](https://github.com/uias/Pageboy/releases/tag/3.0.3)
Released on 2019-02-13

#### Updated
- [#194](https://github.com/uias/Pageboy/pull/194) Improve threading logic.
     - by [remirobert](https://github.com/remirobert)

## [3.0.2](https://github.com/uias/Pageboy/releases/tag/3.0.2)
Released on 2019-02-10

#### Fixed
- [#192](https://github.com/uias/Pageboy/pull/192) Thread safety improvements to resolve `UIPageViewController` crashes.
     - by [RamblinWreck77](https://github.com/RamblinWreck77).

## [3.0.1](https://github.com/uias/Pageboy/releases/tag/3.0.1)
Released on 2018-12-01

#### Fixed
- [#187](https://github.com/uias/Pageboy/issues/187) Issue where using `unowned self` could cause memory crashes.
- [#176](https://github.com/uias/Pageboy/issues/176) Issue where checking UI layout direction could cause threading issues.

## [3.0.0](https://github.com/uias/Pageboy/releases/tag/3.0.0)
Released on 2018-11-13

#### Added
- Support for dynamically inserting a new page via `insertPage(at: PageIndex)`.
- Support for dynamically deleting an existing page via `deletePage(at: PageIndex)`.
- Improved support for Swift 4 and 4.2.

#### Updated
- Status bar style update animation when changing pages now lasts 0.25 seconds.
- Improved Example app with support for in-app Settings.
- Auto-Scrolling will now automatically resume/pause with `viewDidAppear`/`viewWillDisappear` lifecycle events.

#### Fixed
- Numerous memory leaks and performance problems.

---

## [2.6.1](https://github.com/uias/Pageboy/releases/tag/2.6.1)
Released on 2018-10-01

#### Fixed
- [#175](https://github.com/uias/Pageboy/pull/175) Issue where `expectedTransitionIndex` could be incorrect when cancelling scroll events.
     - by [mlarandeau](https://github.com/mlarandeau).

## [2.6.0](https://github.com/uias/Pageboy/releases/tag/2.6.0)
Released on 2018-09-16

#### Updated
- Migrated to use Swift 4.2.

---

## [2.5.4](https://github.com/uias/Pageboy/releases/tag/2.5.4)
Released on 2018-07-19

#### Fixed
- [#166](https://github.com/uias/Pageboy/issues/166) Issue where view controllers would fail to update correctly when transitions were interrupted.
     - by [msaps](https://github.com/msaps).

## [2.5.3](https://github.com/uias/Pageboy/releases/tag/2.5.3)
Released on 2018-07-18

#### Fixed
- [#166](https://github.com/uias/Pageboy/issues/166) Interaction and state issues when transitions were interrupted.
     - by [msaps](https://github.com/msaps).

## [2.5.2](https://github.com/uias/Pageboy/releases/tag/2.5.2)
Released on 2018-06-28

#### Fixed
- [#165](https://github.com/uias/Pageboy/pull/165) Animated transition issues when using a Right-to-left language.
     - by [msaps](https://github.com/msaps).

## [2.5.1](https://github.com/uias/Pageboy/releases/tag/2.5.1)
Released on 2018-04-23

#### Fixed
- [#159](https://github.com/uias/Pageboy/issues/159) Current Index is negative when infinite scroll is enabled and scrolling between ranges.
     - by [msaps](https://github.com/msaps).
     
## [2.5.0](https://github.com/uias/Pageboy/releases/tag/2.5.0)
Released on 2018-04-05

#### Updated
- `parentPageboyViewController` has been renamed to `parentPageboy`.
     - by [msaps](https://github.com/msaps).

#### Fixed
- [#157](https://github.com/uias/Pageboy/issues/157) Fix scroll detection edge case when decelerating on page index.
     - by [msaps](https://github.com/msaps).

---

## [2.4.0](https://github.com/uias/Pageboy/releases/tag/2.4.0)
Released on 2018-02-23

#### Updated
- [#136](https://github.com/uias/Pageboy/issues/136) Add support for default `UIPageViewController` animated transition.
     - by [msaps](https://github.com/msaps).
- [#136](https://github.com/uias/Pageboy/issues/136) Obseleted `default` `Transition`.
     - by [msaps](https://github.com/msaps).
- Mark `showsPageControl` as unavailable rather than deprecated.
     - by [msaps](https://github.com/msaps).

--- 

## [2.3.4](https://github.com/uias/Pageboy/releases/tag/2.3.4)
Released on 2018-02-12

#### Fixed
- [#140](https://github.com/uias/Pageboy/issues/140) Potential crash when scrolling through pages with high velocity.
     - by [msaps](https://github.com/msaps).

## [2.3.3](https://github.com/uias/Pageboy/releases/tag/2.3.3)
Released on 2018-01-30

#### Fixed
- Build issues when trying to integrate with Carthage.
     - by [msaps](https://github.com/msaps).

## [2.3.2](https://github.com/uias/Pageboy/releases/tag/2.3.2)
Released on 2018-01-23

#### Updated
- Refactored and cleaned up internally for some much needed housekeeping.
     - by [msaps](https://github.com/msaps).

## [2.3.1](https://github.com/uias/Pageboy/releases/tag/2.3.1)
Released on 2018-01-06

#### Fixed
-[#133](https://github.com/uias/Pageboy/pull/133) Potential memory issues with UIApplication extension.
     - by [msaps](https://github.com/msaps).

## [2.3.0](https://github.com/uias/Pageboy/releases/tag/2.3.0)
Released on 2018-01-05

#### Updated
- [#131](https://github.com/uias/Pageboy/issues/131) Make Pageboy safe to use in extensions.
     - by [msaps](https://github.com/msaps).

---

## [2.2.0](https://github.com/uias/Pageboy/releases/tag/2.2.0)
Released on 2017-12-20

#### Updated
- [#121](https://github.com/uias/Pageboy/issues/121) Update minimum deployment target to iOS 9.
     - by [msaps](https://github.com/msaps).
- [#129](https://github.com/uias/Pageboy/issues/129) Disable `showsPageControl` temporarily (Due to iOS 11.2 issue).
     - by [msaps](https://github.com/msaps).

---

## [2.1.0](https://github.com/uias/Pageboy/releases/tag/2.1.0)
Released on 2017-11-24

#### Added
- [#116](https://github.com/uias/Pageboy/issues/116) Support for built-in `UIPageViewController` page control.
     - by [msaps](https://github.com/msaps).
- [#116](https://github.com/uias/Pageboy/issues/116) `showsPageControl` to `PageboyViewController`.
     - by [msaps](https://github.com/msaps).

---

## [2.0.4](https://github.com/uias/Pageboy/releases/tag/2.0.4)
Released on 2017-11-11

#### Fixed
- [#118](https://github.com/uias/Pageboy/issues/118) Setting data source in initializer breaks `updateViewControllers`.
     - by [msaps](https://github.com/msaps).

## [2.0.3](https://github.com/uias/Pageboy/releases/tag/2.0.3)
Released on 2017-11-09

#### Fixed
- [#113](https://github.com/uias/Pageboy/issues/113) When swiping too fast PageboyViewController crashes app.
     - by [msaps](https://github.com/msaps).
- [#114](https://github.com/uias/Pageboy/issues/114) Custom preferredStatusBarStyle does not work.
     - by [msaps](https://github.com/msaps).

## [2.0.2](https://github.com/uias/Pageboy/releases/tag/2.0.2)
Released on 2017-10-23

#### Fixed
- [#109](https://github.com/uias/Pageboy/issues/109) Improved blocking logic for animated scroll transitions during other operations.
     - by [msaps](https://github.com/msaps).

## [2.0.1](https://github.com/uias/Pageboy/releases/tag/2.0.1)
Released on 2017-10-22

#### Fixed
- [#109](https://github.com/uias/Pageboy/issues/109) UIPageViewController crash with intense scrolling input.
     - by [msaps](https://github.com/msaps).

## [2.0.0](https://github.com/uias/Pageboy/releases/tag/2.0.0)
Released on 2017-09-13

#### Added
- [#80](https://github.com/uias/Pageboy/issues/80) Swift 4 support.
     - by [msaps](https://github.com/msaps).
- [#81](https://github.com/uias/Pageboy/issues/81) Support for Xcode 9 and iOS 11.
     - by [msaps](https://github.com/msaps).
- [#92](https://github.com/uias/Pageboy/issues/92) tvOS support.
     - by [msaps](https://github.com/msaps).

#### Updated
- [#88](https://github.com/uias/Pageboy/issues/88) Completely redesign `PageboyViewControllerDataSource` to support improved view controller reuse.
     - by [msaps](https://github.com/msaps).
- [#78](https://github.com/uias/Pageboy/issues/78) Update `PageboyViewControllerDataSource` to support the latest recommended code syntax style.
     - by [msaps](https://github.com/msaps).
- Update `PageboyViewControllerDelegate` to support the latest changes to `PageboyViewControllerDataSource `.
     - by [msaps](https://github.com/msaps).

---

## [1.4.1](https://github.com/uias/Pageboy/releases/tag/1.4.1)
Released on 2017-08-14

#### Fixed
- [#99](https://github.com/uias/Pageboy/issues/99) Issues with guarding publicly visible delegates.
     - Added guard statements to `UIScrollViewDelegate` and `UIPageViewControllerDelegate` functions to prevent external injection.
     - Fixed by [msaps](https://github.com/msaps).


## [1.4.0](https://github.com/uias/Pageboy/releases/tag/1.4.0)
Released on 2017-07-25

#### Added
- [#90](https://github.com/uias/Pageboy/issues/90) Support for `UIPageViewController` initialization options.
     - Added `interPageSpacing` property to `PageboyViewController`.
     - Added by [msaps](https://github.com/msaps).

---

## [1.3.3](https://github.com/uias/Pageboy/releases/tag/1.3.3)
Released on 2017-06-29

#### Fixed
- [#86](https://github.com/uias/Pageboy/pull/86) Fix issue where constraints were inadvertantly not added to the internal page view controller. 
     - Fixed by [muukii](https://github.com/muukii).

## [1.3.2](https://github.com/uias/Pageboy/releases/tag/1.3.2)
Released on 2017-06-25

#### Updated
- Renamed utility extensions.

#### Fixed
- [#83](https://github.com/uias/Pageboy/issues/83) Fixed memory issue with custom transitioning support.
     - Fixed by [farshadmb](https://github.com/farshadmb).
- [#85](https://github.com/uias/Pageboy/pull/85) Fixed issue with animated transition positional updates.
     - Transitions with index ranges greater than 1 will now provide positions through the entire range.

## [1.3.1](https://github.com/uias/Pageboy/releases/tag/1.3.1)
Released on 2017-06-24.

#### Fixed
- [#79](https://github.com/uias/Pageboy/issues/79) Add support for Right-to-Left language localisation to iOS 8.

## [1.3.0](https://github.com/uias/Pageboy/releases/tag/1.3.0)
Released on 2017-06-23.

#### Added
- [#75](https://github.com/uias/Pageboy/issues/75) Support for iOS 8.
     - Project deployment target is now `8.0`.
     - Added by [farshadmb](https://github.com/farshadmb) & [msaps](https://github.com/msaps).

---

## [1.2.1](https://github.com/uias/Pageboy/releases/tag/1.2.1)
Released on 2017-06-19.

#### Updated
- The internal `UIPageViewController` is now inserted at the back of all subviews in the `UIViewController`.
     - The Z-Index will persist when changing `navigationOrientation` and other destructive updates.

## [1.2.0](https://github.com/uias/Pageboy/releases/tag/1.2.0)
Released on 2017-06-18.

#### Added
- [#67](https://github.com/uias/Pageboy/issues/67) Improved support for Right-To-Left languages to `PageboyViewController`.
- `parentPageboyViewController` property to `UIViewController` to provide access to parent `PageboyViewController` from child view controllers within the page view controller.
- [#70](https://github.com/uias/Pageboy/issues/70) Success result to `scrollToPage()` function in `PageboyViewController`.
     - Returns whether the scroll was able to be successfully executed.

#### Fixed
- [#71](https://github.com/uias/Pageboy/pull/71) A potential error during layout with scroll positional updates.
     - By AlexZd.

---

## [1.1.2](https://github.com/uias/Pageboy/releases/tag/1.1.2)
Released on 2017-06-18.

#### Fixed
- Fixed issue with animated transitions when using `.vertical` `navigationOrientation`.
- Add support for `.vertical` `navigationOrientation` to example app.
     - By Charles Molyneux.

## [1.1.1](https://github.com/uias/Pageboy/releases/tag/1.1.1)
Released on 2017-06-12.

#### Updated
- Updated project to use Swift 3.2 and compatibility with Xcode 9

#### Fixed
- Fixed issue where it would be possible to cause an error by setting properties on `PageboyViewController` before the internal `UIPageViewController` was initialised.
- Fixed issue where changing `navigationOrientation` would cause properties on `PageboyViewController` to not persist.

## [1.1.0](https://github.com/uias/Pageboy/releases/tag/1.1.0)
Released on 2017-06-07.

#### Added 
- [#57](https://github.com/uias/Pageboy/issues/57) Added support for custom scroll transitions to `PageboyViewController`.
     - Available via the `.transition` (`PageboyViewController.Transition`) property.

#### Fixed
- [#61](https://github.com/uias/Pageboy/issues/61) Fixed AutoLayout issue with internal `UIPageViewController` when in-call status bar is visible.

---

## [1.0.9](https://github.com/uias/Pageboy/releases/tag/1.0.9)
Released on 2017-05-29.

#### Added 
- Added `delaysContentTouches` property to `PageboyViewController`.

#### Updated
- Minor improvements to example project.
- Minor refactoring to `PageboyViewController` extensions.

## [1.0.8](https://github.com/uias/Pageboy/releases/tag/1.0.8)
Released on 2017-05-17.

#### Updated
- Refactored and restructured internal extensions of `PageboyViewController`.
- A fresh coat of paint.

#### Fixed
- Fixed a few UI issues with example project.

## [1.0.7](https://github.com/uias/Pageboy/releases/tag/1.0.7)
Released on 2017-05-07.

#### Added
- `isTracking` property to `PageboyViewController`.
- Default stub protocol implementations for `PageboyViewControllerDelegate`.

#### Updated
- Updated scroll management to use `isTracking` for interaction detection.

## [1.0.6](https://github.com/uias/Pageboy/releases/tag/1.0.6)
Released on 2017-04-26.

#### Updated
- Moved internal `UIPageViewController` initialisation to `viewDidLoad` from `loadView`.

## [1.0.5](https://github.com/uias/Pageboy/releases/tag/1.0.5)
Released on 2017-04-22.

#### Fixed
- [#44](https://github.com/uias/Pageboy/issues/44) Fix incorrect `scrollToPage` function behaviour when at the end of page ranges with infinite scrolling enabled.
     - `.next` used an incorrect animation when scrolling from the upper range to the lower range.
     - `.previous` failed to scroll to a page when scrolling from the lower range to the upper range.

## [1.0.4](https://github.com/uias/Pageboy/releases/tag/1.0.4)
Released on 2017-04-19.

#### Added
- Added `didReload` function to `PageboyViewControllerDelegate` for updating when the `PageboyViewController` successfully reloads its child view controllers.

## [1.0.3](https://github.com/uias/Pageboy/releases/tag/1.0.3)
Released on 2017-04-16.

#### Updated
- [#42](https://github.com/uias/Pageboy/issues/42) Rename `atIndex(index: Int)` to `at(index: Int)` in `PageboyViewController.PageIndex`.
   - Deprecated `atIndex(index: Int)`.

## [1.0.2](https://github.com/uias/Pageboy/releases/tag/1.0.2)
Released on 2017-04-11.

#### Fixed
- Added support for `preferredStatusBarStyle` in child view controllers.
- Added support for `prefersStatusBarHidden` in child view controllers.
- Added animation for transition of status bar appearance on page change.
- Added missing `addChildViewController` call for internal `UIPageViewController`.

## [1.0.1](https://github.com/uias/Pageboy/releases/tag/1.0.1)
Released on 2017-04-05.

#### Fixed
- [#34](https://github.com/uias/Pageboy/issues/34) Fixed issue in `PageboyAutoScroller` where `.handler` would not be released correctly.

## [1.0.0](https://github.com/uias/Pageboy/releases/tag/1.0.0)
Released on 2017-03-28.

#### Updated
- Just a quick version bump to 1.0.0.

---

## [0.4.12](https://github.com/uias/Pageboy/releases/tag/0.4.12)
Released on 2017-03-22.

#### Added
- Improved test coverage for all components of `Pageboy`.

#### Updated
- `isEnabled` is now a public property of `PageboyAutoScroller`.

## [0.4.11](https://github.com/uias/Pageboy/releases/tag/0.4.11)
Released on 2017-03-13.

#### Added
- Added `bounces` property to enable/disable whether the page view controller should bounce at the end of page ranges. [#20](https://github.com/uias/Pageboy/issues/20)

## [0.4.10](https://github.com/uias/Pageboy/releases/tag/0.4.10)
Released on 2017-03-11. 

#### Fixed
- Fixed issue where scrolling aggressively, causing post-boundary deceleration would cause an incorrect `currentIndex` temporarily.

## [0.4.9](https://github.com/uias/Pageboy/releases/tag/0.4.9)
Released on 2017-03-08. 

#### Added
- `PageboyAutoScroller` which provides time-based auto scrolling behaviour to `PageboyViewController`. Available via the `autoScroller` property.

## [0.4.8](https://github.com/uias/Pageboy/releases/tag/0.4.8)
Released on 2017-03-01.

#### Fixed
- Fixed issue where infinite scroll would not provide scroll updates correctly.
- Fixed issue with setting `isInfiniteScrollEnabled` not updating page view controller state correctly. 

## [0.4.7](https://github.com/uias/Pageboy/releases/tag/0.4.7)
Released on 2017-02-28.

#### Fixed
- Fixed issue where updates for scrolling outside of the page view controller `contentSize` would not be correctly reported.

## [0.4.6](https://github.com/uias/Pageboy/releases/tag/0.4.6)
Released on 2017-02-27.

#### Updated
- Ensured that `dataSource` for `PageboyViewController` is weakly referenced.
- Ensured that `delegate` for `PageboyViewController` is weakly referenced.

## [0.4.5](https://github.com/uias/Pageboy/releases/tag/0.4.5)
Released on 2017-02-27.

#### Fixed
- Issue where `animated` parameter on `willScrollToPageAtIndex` would sometimes be incorrect.
- Issue where duplicate positional updates would call `didScrollToPosition` multiple times.

## [0.4.4](https://github.com/uias/Pageboy/releases/tag/0.4.4)
Released on 2017-02-24.

#### Updated
- Improved positional reporting when traversing over multiple pages during a scroll operation.

## [0.4.3](https://github.com/uias/Pageboy/releases/tag/0.4.3)
Released on 2017-02-23.

#### Updated
- Added `animated` parameter to `willScrollToPageAtIndex`.
- Added `animated` parameter to `didScrollToPosition`.
- Added `animated` parameter to `didScrollToPageAtIndex`.

#### Fixed
- Fixed issues with `currentIndex` sync. 

## [0.4.2](https://github.com/uias/Pageboy/releases/tag/0.4.2)
Released on 2017-02-22.

#### Fixed
- Issue where `currentPosition` would not stay in sync with `currentIndex` in certain situations.
- Issue where example app would not support custom default indexes correctly.

## [0.4.1](https://github.com/uias/Pageboy/releases/tag/0.4.1)
Released on 2017-02-17.

#### Added
- Swift Package Manager compatibility.

## [0.4.0](https://github.com/uias/Pageboy/releases/tag/0.4.0)
Released on 2017-02-17.

**Pageboy** initial release - A simple, highly informative page view controller.
