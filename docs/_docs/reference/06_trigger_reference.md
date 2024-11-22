---
layout: page
title: Trigger Reference
permalink: /reference/triggers
description: "A reference for all built-in triggers."
---

## Introduction
G.U.I.D.E ships with a selection of triggers for many use cases. This is a list of all built-in triggers and their configuration settings.

## Chorded Action
This trigger is intended to be used in combination with other triggers. It works differently from other triggers as it will only allow the action to be triggered, if the chorded action is currently triggering. This is most often used to bind the same input to multiple different actions. For example the D-pad on a controller can do different things depending on whether the left trigger is held or not. In this case the chorded action would be holding the left trigger down. If multiple chorded action triggers exist, all of them must be triggering for the action to trigger. The chorded action trigger has the following settings:

| Setting | Description |
|---|---|
| _Chorded action_ | The action that needs to be triggered for this action to be triggered. |
|_Actuation Threshold_ | This setting has no effect for the chorded action trigger. |

## Combo
This trigger allows you to define a sequence of inputs that need to be triggered in order for the action to trigger. This is most often used in fighting games but can also be used to simulate other complex input sequences for example to trigger a magic spell. For the combo trigger you specify a list of actions that need to trigger in the given order. Each action can have a time window in which it needs to be triggered. If the time window is exceeded the combo will reset. Same happens if actions are entered out of order. In addition you can specify a list of cancel actions that will reset the combo if triggered. The combo trigger has the following settings:

| Setting | Description |
|---|---|
|_Enable Debug Print_| If enabled, the trigger will print debug information about the current state of the combo to the console. |
|_Steps_| A list of actions that need to be triggered in order for the combo to trigger. For each action a time frame can be specified in which the action must be completed for the combo to succeed. |
|_Cancel Actions_| A list of actions that will cancel the combo immediately if triggered. |
|_Actuation Threshold_ | This setting has no effect for the combo trigger. |


## Down
This is the most basic trigger. It triggers when the input is pressed down or any axis is non-zero. If you don't specify a trigger for an action then a down trigger with an actuation threshold of 0.0 will be used. The down trigger has the following settings:

| Setting | Description |
|---|---|
|_Actuation Threshold_| The threshold at which the trigger will activate. If the input value is above this threshold the trigger will activate. |


## Hold
This trigger triggers when input is held down for a certain amount of time. An input is considered being held down if the input value is above the actuation threshold. The hold trigger has the following settings:

| Setting | Description |
|---|---|
|_Hold Threshold_| The time in seconds the input needs to be held down for the trigger to activate. |
|_Is One Shot_| If enabled, the trigger will only trigger once when the _Hold Treshold_ is exceeded and will then need to be released before it can trigger again. If disabled, the trigger will continue to  trigger the action every frame after the _Hold Threshold_ is exceeded and while it is still held. |
|_Actuation Threshold_| The threshold at which the trigger will activate. If the input value is above this threshold the trigger will activate. |

## Pressed
This trigger triggers once when the input is pressed down. It will not trigger again until the input is released. This is the equivalent of Godot's `Input.is_action_just_pressed` function. The pressed trigger has the following settings:

| Setting | Description |
|---|---|
|_Actuation Threshold_| The threshold at which the trigger will activate. If the input value is above this threshold the trigger will activate. |

## Pulse
This trigger triggers once when the input is pressed and will continue to trigger in configurable intervals as long as the input is held down. This can be used to simulate the OS key repeat functionality for any input. The pulse trigger has the following settings:

| Setting | Description |
|---|---|
|_Trigger On Start_| If enabled, the trigger will trigger immediately when the input is pressed, otherwise it will wait for the first interval to elapse. |
|_Initial Delay_| The initial delay after the initial actuation before pulsing begins. |
|_Pulse Interval_| The interval in seconds at which the trigger will pulse after the initial delay. |
|_Max Pulses_| The maximum number of pulses that will be triggered. If set to a value <= 0, the trigger will pulse indefinitely. |
|_Actuation Threshold_| The threshold at which the trigger will activate. If the input value is above this threshold the trigger will activate. |

## Tap
This trigger triggers when the input is pressed and released within a certain time frame. Can be used with hold trigger to bind two different actions to the same input (tap for one action, hold for another). The tap trigger has the following settings:

| Setting | Description |
|---|---|
|_Tap Threshold_| The time that the player has to release the input after actuating it. If this time is exceeded, the input is not considered to be a tap. |
|_Actuation Threshold_| The threshold at which the trigger will activate. If the input value is above this threshold the trigger will activate. |
