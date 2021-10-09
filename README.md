![GitHub Cards Preview](https://github.com/sameersyd/Expenso/blob/main/art/EXPENSO_COVER.png?raw=true)

# Expenso
A Simple Expense Tracker App 📱 built to demonstrate the use of SwiftUI, CoreData, Charts, Biometrics (Face & Touch ID), Export CSV and MVVM Architecture 🏗. *Made with love ❤️ by [Sameer Nawaz](https://github.com/sameersyd)*

<br />

## UI Design 🎨

The UI/UX for this Expenso App was designed by <a href="https://github.com/Spikeysanju">@Spikeysanju</a>

***Click to View Expenso app Design from below 👇***

[![Expenso](https://img.shields.io/badge/Expenso-FIGMA-black.svg?style=for-the-badge&logo=figma)](https://www.figma.com/file/Z5KMfiwo9RYtYBUMRSIfHh/Expense-Tracker-App?node-id=140%3A1016)

<br />

## Light Mode 🌞
Dashboard | Face & Touch ID | All Income | All Expense | Add Transaction 
--- | --- | --- |--- |--- 
![](https://github.com/sameersyd/Expenso/blob/main/art/dashboard.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/auth_faceid.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/income_stat.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/expense_stat.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/add_transaction_attach.png) 

<br />

## Dark Mode 🌚
Dashboard | Face & Touch ID | All Income | All Expense | Add Transaction 
--- | --- | --- |--- |--- 
![](https://github.com/sameersyd/Expenso/blob/main/art/dashboard_dark.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/auth_faceid_dk.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/income_stat_dk.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/expense_stat_dk.png) | ![](https://github.com/sameersyd/Expenso-iOS/blob/main/art/add_transaction_attach_dark.png) 

<br />

## Built With 🛠
- [SwiftUI](https://developer.apple.com/documentation/swiftui/) - SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift.
- [CoreData](https://developer.apple.com/documentation/coredata) - Framework used to manage the model layer objects in the application.
- [Figma](https://figma.com/) - Figma is a vector graphics editor and prototyping tool which is primarily web-based.

<br />

## Project Structure
    
    Expenso # Target
    |
    ├── CoreData            # CoreData ManagedObject
    |
    ├── view
    │   ├── main                    # Main root folder
    |   │   ├── view                # SwiftUI MainView
    |   │   └── viewmodel           # ViewModel for MainView
    │   ├── Expense                 # Expense root folder
    |   |   |__ ExpenseView         # ExpenseView (Dashboard)
    │   ├── AddExpense              # Add Expense root folder
    |   |   |__ AddExpense          # Add Expense
    │   ├── ExpenseDetailed         # Expense Details root folder
    |   |   |__ ExpenseDetailed     # Expense Details
    │   ├── ExpenseFilter           # Expense Filter root folder
    |   |   |__ ExpenseFilter       # Expense Filter
    │   ├── ExpenseSettings         # Expense Settings root folder
    |   |   |__ ExpenseSettings     # Expense Settings
    │   ├── About                   # About root folder
    |   |   |__ about               # About
    ├── Helpers                     # All extension functions


<br />

## Ohh You want Android App Too? 📱 
Well, we've Android version here, Checkout the Android version of this app <a href="https://github.com/Spikeysanju/Expenso">Expenso</a>

<br />

## Contribute
If you want to contribute to this app, you're always welcome!
See [Contributing Guidelines](https://github.com/sameersyd/Expenso/blob/main/CONTRIBUTION.md). 

<br />

## Donation
If this project helped you reduce time to develop, you can buy me a cup of coffee :) 

<br />

<a href="https://www.buymeacoffee.com/sameersyd" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## License
```
    Apache 2.0 License


    Copyright 2021 Sameer Nawaz

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

```
