#!/usr/bin/env bash

# VIPER module generator with associated Storyboard

if [ $# -eq 0 ]; then 
	echo "Please enter a module name";
	exit 1;
fi

MODULE="$1"
APPMODULE="My Project"
echo "Generating files for the module $MODULE..."

echo "${MODULE}View..."

cat << EOF > ${MODULE}ViewController.swift
//
//  Viper Module
//  ${MODULE}ViewController.swift
//

import Foundation
import UIKit

class ${MODULE}ViewController: UIViewController {
	var presenter: ${MODULE}ViewOutput!

	override func viewDidLoad() {
		view.translatesAutoresizingMaskIntoConstraints = false;
	}
}

extension ${MODULE}ViewController: ${MODULE}ViewInput {
	
}
EOF

echo "${MODULE}Interactor..."

cat << EOF > ${MODULE}Interactor.swift
//
//  Viper Module
//  ${MODULE}Interactor.swift
//

import Foundation

class ${MODULE}Interactor {
	weak var presenter: ${MODULE}InteractorOutput!
}

extension ${MODULE}Interactor: ${MODULE}InteractorInput {
	
}
EOF

echo "${MODULE}Presenter..."

cat << EOF > ${MODULE}Presenter.swift
//
//  Viper Module
//  ${MODULE}Presenter.swift
//

import Foundation

class ${MODULE}Presenter {
	weak var view: ${MODULE}ViewInput!
	var interactor: ${MODULE}InteractorInput!
	weak var output: ${MODULE}ModuleOutput!
}

extension ${MODULE}Presenter: ${MODULE}ModuleInput {
	
}

extension ${MODULE}Presenter: ${MODULE}InteractorOutput {
	
}

extension ${MODULE}Presenter: ${MODULE}ViewOutput {
	
}
EOF

echo "${MODULE}Assembly..."

cat << EOF > ${MODULE}Assembly.swift
//
//  Viper Module
//  ${MODULE}Assembly.swift
//

class ${MODULE}Assembly {
	static func setup(_ viewController: ${MODULE}ViewController, delegate: ${MODULE}ModuleOutput) -> ${MODULE}ModuleInput {
		let presenter = ${MODULE}Presenter()
		let interactor = ${MODULE}Interactor()

		viewController.presenter = presenter
		interactor.presenter = presenter
		presenter.view = viewController
		presenter.interactor = interactor
		presenter.output = delegate;
		return presenter;
	}
}
EOF

echo "${MODULE}Contract..."

cat << EOF > ${MODULE}Contract.swift
//
//  Viper Module
//  ${MODULE}Contract.swift
//

protocol ${MODULE}ModuleInput: class {
	
}

protocol ${MODULE}ModuleOutput: class {
	
}

protocol ${MODULE}ViewInput: class {
	
}

protocol ${MODULE}ViewOutput: class {
	
}

protocol ${MODULE}InteractorInput: class {
	
}

protocol ${MODULE}InteractorOutput: class {
	
}
EOF


echo "${MODULE}Storyboard..."

cat << EOF > ${MODULE}.storyboard
<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="14113" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES" initialViewController="4GP-Zt-UPk">
    <device id="retina4_7" orientation="landscape">
        <adaptation id="fullscreen"/>
    </device>
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="14088"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <scenes>
        <!-- $MODULE -->
        <scene sceneID="Y2N-Pa-oqu">
            <objects>
                <viewController id="4GP-Zt-UPk" customClass="${MODULE}ViewController" customModule="$APPMODULE" customModuleProvider="target" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="cGo-z7-B9y">
                        <rect key="frame" x="0.0" y="0.0" width="667" height="375"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
                        <viewLayoutGuide key="safeArea" id="Nqe-Eo-wNv"/>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="had-1g-y9r" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="-338" y="108"/>
        </scene>
    </scenes>
</document>
EOF

