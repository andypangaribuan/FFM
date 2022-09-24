# CHANGELOG
All notable changes to this project will be documented in this file.

## 1.0.15
### Added
* add pipe.onUpdate[2-9] for multiple pipe onUpdate

## 1.0.14
### Added
* ff.crypto.aesECBEncrypt for encryption using aes-ecb

## 1.0.13
### Fixed
* Example project implementation of FPipe.
### Added
* ff.func.subscribeValidationLapse<T> to implement lapse action when pipe subscribe.
* Holder on pipe using Map.
* onUpdateWithErrUpdate on pipe to easier implementation when want to get update the data end error.
* Implement softUpdate on FPipeErrModel.
* Multiple stream builder to support onUpdateWithErrUpdate on FPipe.
* FColumnExpandedScroll widget.
* Change implementation of holder on pipe to FHorizontalSizeMeasurer.
### Modified
* remove protected on pageOpenAndRemovePrevious and dismissKeyboard on FPageLogic.

## 1.0.12
### Fixed
* Trigger onChange when updateRenderObject to handle performLayout dynamically on FHorizontalSizeMeasurer.
### Added
* FSimpleVisibility for visibility: visible, invisible and gone.
* Splash color, highlight color, width, heigh, margin, visibility, and shape to FSimpleButton.
* FPageTransitionHolder to hold the transition page, so pageOpen can have ability to perform transition injection for each variable used by FPageTransition.
* Integrate FPageTransitionHolder to FPageTransition.
* randomChar to ff.func for generating the ids.
### Modified
* Change subscription listener type from array to map for id support, this means subscription listener can be remove from queue using disposer when the pipe used on global app.

## 1.0.11
### Fixed
* FSimpleButton padding and margin position.
### Added
* FSimpleButton highlightColor.

## 1.0.10
### Added
* FHorizontalSizeMeasurer for measuring the horizontal widget such as row.

## 1.0.9
### Added
* FSimpleButton widget as alternative to material button

## 1.0.8
### Added
* FSizeMeasure widget to measure widget size

## 1.0.7
### Modified
* FPipe implement direct update on error value to the pipe

## 1.0.6
### Added
* FTimer: support start, pause, reset and resetAndStart


## 1.0.5
### Modified
* Sink and textEditController listener for broadcasting to all subscriber on FPipe
* FPipe prevent send multiple event to all subscriber with same value


## 1.0.4
### Added
* add ff.func.waitNotNull to check async the value already not null or not.
* add onBuildLayoutFirstCall to pageLogic


## 1.0.3
### Modified
* Allow public initialize for FDisposer


## 1.0.2
### Modified
* FPage concept


## 1.0.1
### Added
* FPageLogic: page transition animation
* FPipe: error pipe embedded, subscribe when using withTextEditingController
* ff: logger, time
* example project

### Changed
* FPipe: onUpdate follow the T generic type


## 1.0.0
### Added
* FPage, FPageLogic: split UI and logic, and provide connection to each other.
* FPipe: easy state management with auto disposal.
