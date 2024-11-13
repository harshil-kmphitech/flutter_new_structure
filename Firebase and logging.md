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

By running this command, you will get your projects list. Manage project selection using the arrow keys `up` or `down`.

```
mac@192 flutter_fire_cli % flutterfire configure
i Found 5 Firebase projects.
? Select a Firebase project to configure your Flutter application with >
❯ alamus-ebccf (ALAMUS)        
  flient-app (Flient app)
  know-your-c35e4 (know your pet)
  shurinc-9d0eb (Shurinc)
  transporthub-f314d (Transporthub)      
  <create a new project>
```

If you need to create a new project, move your selection to create a new project.

After going through create a new project, you will have some options. Now enter your new project ID.

**Important:** Ensure your project ID contains only lowercase letters and dashes.


```
✔ Select a Firebase project to configure your Flutter application with <create a new project>
? Enter a project id for your new Firebase project (e.g. my-cool-project) › 
```

After you select or create a project, you will see your project's platform. To manage project selection, use the up and down arrow keys. To select or unselect a platform, press the `space bar`.

```
i New Firebase project flutterfire-23423 created successfully.
? Which platforms should your configuration support (use arrow keys & space to select)? ›     
✔ android
✔ ios
✔ macos
✔ web
✔ windows   
```

Mandatory Step: If you have not already changed your Android package name or iOS bundle ID, enter a custom one here.

```
? Which Android application id (or package name) do you want to use for this configuration, e.g. 'com.example.app'? ›
```

That's it! You have now initialized Firebase for your project on all selected platforms.

## Adding Crashlytics to Code

[check here](https://github.com/harshil-kmphitech/flutter_new_structure/blob/main/lib/app/utils/helpers/injectable/injectable.dart)