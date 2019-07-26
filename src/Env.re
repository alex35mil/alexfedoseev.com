type process;
type env;

[@bs.val] external process: process = "process";
[@bs.get] external env: process => env = "env";

[@bs.get] external twitterHandle: env => string = "TWITTER_HANDLE";
let twitterHandle = process->env->twitterHandle;

[@bs.get] external facebookAppId: env => string = "FACEBOOK_APP_ID";
let facebookAppId = process->env->facebookAppId;
