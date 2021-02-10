#### 4.0.0 (2021-02-08)

##### Chores

* **core:**
  *  formatting changes for bsc compiler (212de40f)
  *  minor fix and beacon conformanace (aff75f24)
  *  Updates formatting for bsc compiler (9e04917e)
  *  Changes path handling to now be relative to entry.json (7c7637f0)
  *  updates rlog (b7fed17c)
  * Use newer dismiss api for settign success in login screens (c6dade27)
  *  Bring plugins up to date with latest dynamicContainer api (b92330ba)
  *  updates changelog (77605da5)
* **logout_screen_roku:**  Minor style fix (3f9697a3)
* **tests:**
  *  Fixes failing tests (c43690ba)
  *  Removes errant @only (4ac86002)
* **entitlements_item_loader_prehook:**  do not show if item is already loaded (ef7b67c4)
* **login_screen_roku:**  Do not show if already logged in (9153bf44)
* **inplayer_entitlements_plugin:**  Fixes failing tests (ab4131ad)
* **regcode_login_screen_roku:**  Updates RegcodeLoginScreenVM to match latest api (c6876395)
*  bounce to 3.1.1 (adebefa9)

##### New Features

* **ZMPXVideoPlaybackPrehook:**  Adds par xml format support (0c89f34e)
* **inplayer_entitlements_plugin:**
  *  Adds cookie support (10d02b83)
  *  Uses product_code, instead of product_name, as per the new apim (288d95b3)
  *  use new base API to indicate item level entitlements (8fa8c313)
  *  Updates with latest info on the extensions and api usage (c9e14e01)
  *  Implements inplayer entitlements (7c6ad9c3)
* **mpx_adobe_prehook_roku:**  Adds prehook for doing mpx url resolution, using tve short media token (7aecfc97)
* **tve_token_loader_prehook_roku:**
  *  Adds ability to specify if using rss template resource ID or simple resourceID (e0198c5a)
  *  Adds new ZTVETokenLoaderPrehook plugin, which can load adobe tokens into the session store for use downstream (6889965c)
* **awsLoginScreen:** send lowercase userName to the api (#21) (e4af618b)
* **logout_screen_roku:**   Improves styling (55b4b34f)
* **register_screen_roku:**
  *   Improves styling and localization support (55914f32)
  *  Adds generic register screen (5e5af4ba)
* **login_screen_roku:**
  *   Improves styling and localization support (b8babf67)
  *  Adds generic LoginScreen (e5a18a3a)
* **forgot_password_screen_roku:**
  *  Improves styling and localization support (b42d367e)
  *  Adds ForgotPasswordScreen (bb53a8a4)
* **analytics:**  Updates plugins to conform to latest API for _identify (a835dad4)
* **bitmovin:**
  *  Reverts experimental feature that client no longer wants, to attempt to fix 5.1 issues (ec860836)
  *  enables stereo playback by default to avoid 5.1 audio issues (39dcc598)
  *  Adds support for inline video playback - the framework now allows us to play video content under the rest of the apps content (8a40ff8f)
* **inplayer_auth_plugin_roku:**  Adds InPlayerAuthPlugin (6ae94d6b)
* **inplayer_entitlements:** Adds Inplayer Entitlements Plugin (fd6e94e1)
* **entitlements_item_loader_prehook:**  Adds a generic prehook that can load an items url/other metadata via a function call on ennitlements plugins, to save us needing a specific task for each of these url resolvers, which are usually coupled to entitlements (autorization) anyhow (15ed2ad3)
* **warning_message_screen_roku:**  Adds case insensitivity to matching values (b647fbde)
* **aws_cognito_login_screen_roku:**  Can cancel non flow blocker login screens (447a345c)

##### Bug Fixes

* **deeplinking:**  fixes loading spinner not showing for parent screen (1c914aa1)
* **core:**  adds launch beacon support to dialog (4eea964a)
* **aws_cognito_login_screen_roku:**
  *  Adds support for logging out when login screen is showed before home screen (12bbbb54)
  *  Fix failing test (6b0eaec0)
* **inplayer_entitlements_plugin:**
  *  Fixes missing token issue (d599c905)
  *  Updates to latest inplayer API. fully tested as working (42d9edbc)
  *  Uses code for matching fees, instead of name (0826407e)
  *  Updates plugin to use roku product names, instead of sku (code), workaround until a time when inplayer update their api to use sku. (4af2d4de)
  *  Send name, not code, for registering purchases (d266e2cf)
  *  Prevents duplicate items, and sets missing fields (c5fc90d8)
  *  Fixes issues that prevented purchases working (f68fc5f5)
* **inplayer_auth_plugin_roku:**
  *  Fixes failing tests (3e082758)
  *  Hacky workaround for surname suddenly being required (bbc202c4)
* **tve_token_loader_prehook_roku:**  Adds missing task wrapper for prehook (da786907)
* **entitlements_item_loader_prehook:**  Fix failing tests (eb6f29f7)
* **segment_analytics:**
  *  Disable anon identify (eb3ad19e)
  * Addresses issue that stops analytics after logging out. Short circuit analytics plugins should still count as identified, as segment always has anon as a minimum (18d8cc82)
  *  Sends hashed id on identify (c7021e8f)
  *  Hashes ids (d9acdb0c)
  *  Fixes crash when trais or options are invalid (e310bac1)
  *  Hashes ids (7f058696)
  *  Always use anonymousid, and remove unidentify functoin (ddca3bcc)
* **register_screen_roku:**
  *  Centers loading spinner (bc63bfde)
  *  Removes notion of done screen at end of register and fixes keyboard issues (0ab990ff)
* **logout_screen_roku:**
  *  Fixes layout issues (180efef2)
  *  Log out screen will now send analytics BEFORE calling auth manager (2d895882)
  *  Do not log sign out analytics until the auth task completes (0ff1da64)
* **forgot_password_screen_roku:**  Fixes layout issues (85076330)
* **login_screen_roku:**  Do not require authentication when a content item does not have requires_authentication extension (ef5cd2ff)
* **Regcode login screen:**  login analytics event name (#16) (7ae4ed3a)
* **analytics:**  Do not call idenitfy from analytics plugins. (3fcb2955)
* **google_analytics_roku:**  Fixes event factory not being present in IOC; causing analytics calls to silently fail (17df19cc)
* **roku_deeplinking_screen:**  Fixes issue that prevents deep linking playback (68d282e1)
* **regcode_login_screen_roku:**  Fixes crash on regcode screen when leaving quickly (96d21fdd)
* **roku_search_screen:**  Hides spinner, if too few chars are entered (ecfaa25f)

##### Other Changes

* applicaster-plugins/zapp-roku-plugins (47fbcca1)

#### 3.1.2 (2020-08-20)

##### Chores

* **core:**  updates changelog (376c91c3)
* **test:**  Removes errant @only (7f8f3ebe)

##### New Features

* **analytics:**  Updates plugins to conform to latest API for _identify (a8203e35)
* **bitmovin:**
  *  Reverts experimental feature that client no longer wants, to attempt to fix 5.1 issues (6335ab33)
  *  enables stereo playback by default to avoid 5.1 audio issues (332bb44a)
* **warning_message_screen_roku:**  Adds case insensitivity to matching values (4fe79594)

##### Bug Fixes

* **segment_analytics:**
  *  Fixes crash when trais or options are invalid (245d6c9b)
  *  Always use anonymousid, and remove unidentify functoin (287b6e08)
* **logout_screen_roku:**
  *  Log out screen will now send analytics BEFORE calling auth manager (fa4a6218)
  *  Do not log sign out analytics until the auth task completes (daecc404)
* **Regcode login screen:**  login analytics event name (#16) (1a0e8ebc)
* **analytics:**  Do not call idenitfy from analytics plugins. (3c6fef44)

##### Other Changes

* applicaster-plugins/zapp-roku-plugins into staging (11204364)
* applicaster-plugins/zapp-roku-plugins into staging (63db7d8c)

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

