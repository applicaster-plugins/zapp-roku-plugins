#### 3.1.1 (2020-06-02)

##### New Features

* **aws_cognito_login_screen_roku:**  Can cancel non flow blocker login screens (447a345c)
* **bitmovin:**  Adds support for inline video playback - the framework now allows us to play video content under the rest of the apps content (8a40ff8f)

##### Bug Fixes

* **regcode_login_screen_roku:**  Fixes crash on regcode screen when leaving quickly (96d21fdd)
* **roku_search_screen:**  Hides spinner, if too few chars are entered (ecfaa25f)

#### 3.1.0 (2020-05-27)

##### Bug Fixes

* **roku_search_screen:**  Adds full screen flag to plugin (8c402750)

#### 3.0.5 (2020-05-18)

##### Chores

* **regcode_login_screen_roku:**
  *  Remove errant @only (2dc71ef0)
  *  Remove errant @only from test (dff1a6a8)
  *  Adds more tests, and improves styling and api usage (2e607b80)
* **components:**  Makes Various styling fixes (5a098697)
* **tests:**  Fixes failing tests (9af48921)
* **aws_cognito_login_screen_roku:**
  *  Improves api usage and adds more tests (791e7377)
  *  Adds missing refresh tests (dcc3fa61)
* **gigya_auth_plugin_roku:**  Adds tests (8f46b4db)
* **AdobePrimetimeAuthPlugin:**  Modernizes syntax throughout, and uses latest apis. Overhauls tests (ba1badce)
* **segment_analytics:**  Improves account info handling (6a54ae83)
* **auth_plugins:**  Updates to leverage core api improvements (d55fbfd8)
* **gigya_login_screen_roku:**  Removes authentication code (e034525d)
* **core:**  Fixes failing tests (ef53c423)

##### New Features

* **warning_message_screen_roku:**  Adds support for selecting last item in DSP as the warning message source (8c531c47)
* **AdobeAccessEnabler:**  Stores correct expiry time for token (fcc93835)
* **regcode_login_screen_roku:**
  *  Improves logic for ascertaining if the screen should display, and fixe a couple of minor test failures (fb43ec5c)
  *  Adds support for refresh and hook flow dismissal when logged in (2620aa6f)
* **generic_url_token_appender:**  Adds generic url appender (10c65778)
* **gigya_auth_plugin_roku:**  Splits gigy into bonafide auth plugin (bfa9c202)
* **logout_screen_roku:**  Adds support for logging out of specific provider (0438074b)
* **segment_analytics:**  Updates to latest base analytics api (58637d5e)
* **roku_search_screen:**  Uses search id, instead of search name (92d100c6)
* **roku_deeplinking_screen:**
  *  Simplifies the deeplinking controllers behaviour (91fe1415)
  *  Updates API for screen and flow management (e66ec8d9)

##### Bug Fixes

* **regcode_login_screen_roku:**
  *  Imrpoves styling (83c75fc0)
  *  Ensures show event is tracked for non-hook flows (f507ce92)
  *  Improves dismissal behaviour when not in a hook flow (63c8601a)
  *  Improves handling of background while loading videos (1e96fc26)
  *  Fixes failing test (30eb7357)
  *  Fixes issue that could cause regcode screen to appear for free/unlocked items (6f57b1f0)
  *  Fixes incompatabilities with view style and legacy json format (a6a8b01e)
* **segment_analytics:**
  *  Sends correct account settings with default properties (ad553138)
  *  Improves idenitifcation, and cases where no user is logged in (7211bcac)
  *  Fixes crash on segment analytics plugin identify (62bc7b0f)
  *  Fixes mapping problems (b4fe76b3)
* **AdobeAccessEnabler:**  Sets correct user id on session user (1eaa51ac)
* **accounts:**  Fixes various account issues (4bb81e4c)
* **gigya_auth_plugin_roku:**
  *  Fixes crash on login (eadd78cc)
  *  Fixes gigya auth plugin tests (7818b54b)
  *  Fixes for auth plugin, seems matching tests got added in separate commit (dc8498b3)
* **logout_screen_roku:**  Fixes errant authTask call (057bb7bc)
* **Adobe:**  Fixes a couple of issues in Adobe login screens (69f12e66)
* **gigya_login_screen_roku:**
  *  Updates segment events (316c5ae6)
  *  Fixes failing tests (c7192362)
* **aws_cognito_login_screen_roku:**  Fixes failing tests (aa8fd1d7)
* **bitmovin:**  Fixes unit test failures (c3cadced)

##### Other Changes

* **regcode_login_screen_roku:**  Adds more labels for configuring messaging (195540b8)

