# FlutterFire CLI

A CLI to help with using [Firebase](https://firebase.google.com/docs/flutter) in your Flutter applications.

## Setup Firebase


**Installation:** The FlutterFire CLI depends on the underlying [Firebase CLI](https://firebase.google.com/docs/cli). If you haven't already done so, make sure you have the Firebase CLI installed on your machine. If not, make sure you have [node.js](https://nodejs.org/en) on your machine and Install the Firebase CLI via npm by running the following command:

```
npm install -g firebase-tools
```

and if your machine not have **npm** installed try running the following command

```
curl -sL https://firebase.tools | bash
```

After installing the CLI, you must authenticate. Then you can confirm authentication by listing your Firebase projects.

1. Log into Firebase using your Google account by running the following command:

```
firebase login
```

2. Test that the CLI is properly installed and accessing your account by listing your Firebase projects. Run the following command:

```
firebase projects:list
```

## Install

To install [FlutterFire CLI](https://firebase.flutter.dev/docs/overview), run the following command:

```bash
dart pub global activate flutterfire_cli
```

## Usage

FlutterFire can be initialized from Dart on all platforms using Firebase.initializeApp, however the options for different platforms can vary. The FlutterFire CLI can help, by generating a file (by default called firebase_options.dart) which can be used when calling the initialization method.

The FlutterFire CLI extracts information from your Firebase project and selected project applications to generate all the configuration for a specific platform.

In the root of your application, run the `configure` command:

```
flutterfire configure
```

select your project, after that select platforms