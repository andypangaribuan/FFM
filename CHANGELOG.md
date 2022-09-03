# CHANGELOG
All notable changes to this project will be documented in this file.

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
