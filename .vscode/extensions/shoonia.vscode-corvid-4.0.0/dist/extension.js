'use strict';

const vscode = require('vscode');
const path = require('path');
const fs = require('fs');
const promises = require('fs/promises');

const backend = [
	{
		name: "import wixBilling from 'wix-billing-backend'",
		kind: 8,
		snippet: "wixBilling from 'wix-billing-backend';",
		docs: "The [wix-billing-backend](https://www.wix.com/velo/reference/wix-billing-backend) module contains functionality for working with billing features, such as price quotes and invoices."
	},
	{
		name: "import wixBookingsBackend from 'wix-bookings-backend'",
		kind: 8,
		snippet: "{ bookings } from 'wix-bookings-backend';",
		detail: "{ bookings } from 'wix-bookings-backend'",
		docs: "The [wix-bookings-backend](https://www.wix.com/velo/reference/wix-bookings-backend) module contains functionality for working with bookings from backend code."
	},
	{
		name: "import wixCRM from 'wix-crm-backend'",
		kind: 8,
		snippet: "wixCRM from 'wix-crm-backend';",
		docs: "The [wix-crm-backend](https://www.wix.com/velo/reference/wix-crm-backend) module contains functionality for working with your site's contacts from backend code."
	},
	{
		name: "import wixMarketing from 'wix-marketing-backend'",
		kind: 8,
		snippet: "{ coupons } from 'wix-marketing-backend';",
		detail: "{ coupons } from 'wix-marketing-backend'",
		docs: "The [wix-marketing-backend](https://www.wix.com/velo/reference/wix-marketing-backend) module contains functionality for working with your site's marketing tools from backend code."
	},
	{
		name: "import wixPay from 'wix-pay-backend'",
		kind: 8,
		snippet: "wixPay from 'wix-pay-backend';",
		docs: "The [wix-pay-backend](https://www.wix.com/velo/reference/wix-pay-backend) module contains functionality for working with payments from backend code."
	},
	{
		name: "import wixSite from 'wix-site-backend'",
		kind: 8,
		snippet: "wixSite from 'wix-site-backend';",
		docs: "The [wix-site-backend](https://www.wix.com/velo/reference/wix-site-backend) module contains functionality for obtaining information about your site and its pages from backend code."
	},
	{
		name: "import wixStores from 'wix-stores-backend'",
		kind: 8,
		snippet: "wixStores from 'wix-stores-backend';",
		docs: "The [wix-stores-backend](https://www.wix.com/velo/reference/wix-stores-backend) module contains functionality for working with your site's store from backend code."
	},
	{
		name: "import wixUsers from 'wix-users-backend'",
		kind: 8,
		snippet: "wixUsers from 'wix-users-backend';",
		docs: "The [wix-users-backend](https://www.wix.com/velo/reference/wix-users-backend) module contains functionality for working with your site's users from backend code."
	},
	{
		name: "import wixCaptcha from 'wix-captcha-backend'",
		kind: 8,
		snippet: "wixCaptcha from 'wix-captcha-backend';",
		docs: "The [wix-captcha-backend](https://www.wix.com/velo/reference/wix-captcha-backend) module contains functionality for working with the reCAPTCHA element from backend code.\n\n*Note: This feature is not yet available to all users.*"
	},
	{
		name: "import wixMediaManager from 'wix-media-backend'",
		kind: 8,
		snippet: "{ mediaManager } from 'wix-media-backend';",
		detail: "{ mediaManager } from 'wix-media-backend'",
		docs: "The [wix-media-backend](https://www.wix.com/velo/reference/wix-media-backend) module contains functionality for working with media from backend code."
	},
	{
		name: "import wixRouter from 'wix-router'",
		kind: 8,
		snippet: "{ ${1|ok,notFound,next,redirect,forbidden,sendStatus|} } from 'wix-router';",
		docs: "This module contains the APIs for code routers and data binding router hooks.\n\n[wix-router](https://www.wix.com/velo/reference/wix-router)"
	},
	{
		name: "import wixHttpFunctions from 'wix-http-functions'",
		kind: 8,
		snippet: "{ ${1|ok,get,post,use,badRequest,notFound,serverError,created,delete,forbidden,options,put,response|} } from 'wix-http-functions';",
		docs: "HTTP functions are used to expose an API of your site's functionality.\n\n[wix-http-functions](https://www.wix.com/velo/reference/wix-http-functions)"
	},
	{
		name: "import wixChat from 'wix-chat-backend'",
		kind: 8,
		snippet: "wixChat from 'wix-chat-backend';",
		docs: "The [wix-chat-backend](https://www.wix.com/velo/reference/wix-chat-backend) module contains functionality for working with the Wix Chat application from backend code."
	},
	{
		name: "import wixSecretsBackend from 'wix-secrets-backend'",
		kind: 8,
		snippet: "{ ${1|getSecret,listSecretInfo,createSecret,deleteSecret,updateSecre|} } from 'wix-secrets-backend';",
		docs: "The [wix-secrets-backend](https://www.wix.com/velo/reference/wix-secrets-backend) module contains functionality for retrieving secrets you safely store in your site's [Secrets Manager](https://support.wix.com/en/article/velo-about-the-secrets-manager).\n\nNote: This feature is not yet available to all users."
	},
	{
		name: "import wixRealtimeBackend from 'wix-realtime-backend'",
		kind: 8,
		snippet: "{ permissionsRouter$1, publish$2 } from 'wix-realtime-backend';",
		docs: "The [wix-realtime](https://www.wix.com/velo/reference/wix-realtime-backend) module contains functionality for publishing messages on channels that site visitors can subscribe to and for managing channel permissions."
	},
	{
		name: "import wixPricingPlansBackend from 'wix-pricing-plans-backend'",
		kind: 8,
		snippet: "wixPricingPlansBackend from 'wix-pricing-plans-backend';",
		docs: "The [wix-pricing-plans-backend](https://www.wix.com/velo/reference/wix-pricing-plans-backend) module contains functionality for managing your site's pricing plans from backend code."
	},
	{
		name: "import { wixEvents } from 'wix-events-backend'",
		kind: 8,
		snippet: "{ wixEvents } from 'wix-events-backend';",
		docs: "The [wix-events-backend](https://www.wix.com/velo/reference/wix-events-backend) provides functionality for creating, updating, and managing Wix events."
	}
];

const frontend = [
	{
		name: "import wixAnimations from 'wix-animations'",
		kind: 8,
		snippet: "{ timeline } from 'wix-animations';",
		docs: "The [wix-animations](https://www.wix.com/velo/reference/wix-animations) module contains functionality for working with animations."
	},
	{
		name: "import wixBookings from 'wix-bookings'",
		kind: 8,
		snippet: "wixBookings from 'wix-bookings';",
		docs: "The [wix-bookings](https://www.wix.com/velo/reference/wix-bookings) module contains functionality for working with bookings from client-side code."
	},
	{
		name: "import wixLocation from 'wix-location'",
		kind: 8,
		snippet: "wixLocation from 'wix-location';",
		docs: "The [wix-location](https://www.wix.com/velo/reference/wix-location) module contains functionality for getting information about the URL of the current page and for navigating to other pages."
	},
	{
		name: "import wixPaidPlans from 'wix-paid-plans'",
		kind: 8,
		snippet: "wixPaidPlans from 'wix-paid-plans';",
		docs: "The [wix-paid-plans](https://www.wix.com/velo/reference/wix-paid-plans) module contains functionality for working with paid plans from client-side code."
	},
	{
		name: "import wixPay from 'wix-pay'",
		kind: 8,
		snippet: "wixPay from 'wix-pay';",
		docs: "The [wix-pay](https://www.wix.com/velo/reference/wix-pay) module contains functionality for working with payments from client-side code."
	},
	{
		name: "import wixSite from 'wix-site'",
		kind: 8,
		snippet: "wixSite from 'wix-site';",
		docs: "The [wix-site](https://www.wix.com/velo/reference/wix-site) module contains functionality for obtaining information about your site and its pages."
	},
	{
		name: "import wixStorage from 'wix-storage'",
		kind: 8,
		snippet: "{ ${1|local,session,memory|} } from 'wix-storage';",
		detail: "{ local } from 'wix-storage'\n{ session } from 'wix-storage'\n{ memory } from 'wix-storage'",
		docs: "The [wix-storage](https://www.wix.com/velo/reference/wix-storage) module contains functionality for the persistent storage of key/value data in the site visitor's browser."
	},
	{
		name: "import wixStores from 'wix-stores'",
		kind: 8,
		snippet: "wixStores from 'wix-stores';",
		docs: "The [wix-stores](https://www.wix.com/velo/reference/wix-stores) module contains functionality for working with your site's store from from client-side code."
	},
	{
		name: "import wixUsers from 'wix-users'",
		kind: 8,
		snippet: "wixUsers from 'wix-users';",
		docs: "The [wix-users](https://www.wix.com/velo/reference/wix-users) module contains functionality for working with your site's users from client-side code."
	},
	{
		name: "import wixWindow from 'wix-window'",
		kind: 8,
		snippet: "wixWindow from 'wix-window';",
		docs: "The [wix-window](https://www.wix.com/velo/reference/wix-window) module contains functionality that pertains to the current browser window."
	},
	{
		name: "import wixSeo from 'wix-seo'",
		kind: 8,
		snippet: "wixSeo from 'wix-seo';",
		docs: "The [wix-seo](https://www.wix.com/velo/reference/wix-seo) module contains functionality for working with your site's SEO from client-side code."
	},
	{
		name: "import wixEvents from 'wix-events'",
		kind: 8,
		snippet: "wixEvents from 'wix-events';",
		docs: "The [wix-events](https://www.wix.com/velo/reference/wix-events) module contains functionality for working with Wix Events from client-side code."
	},
	{
		name: "import wixSearch from 'wix-search'",
		kind: 8,
		snippet: "wixSearch from 'wix-search';",
		docs: "The [wix-search](https://www.wix.com/velo/reference/wix-search) module contains functionality for searching a site."
	},
	{
		name: "import wixRealtime from 'wix-realtime'",
		kind: 8,
		snippet: "wixRealtime from 'wix-realtime';",
		docs: "The [wix-realtime](https://www.wix.com/velo/reference/wix-realtime) module contains functionality for publishing messages on channels that site visitors can subscribe to."
	}
];

const site = [
	{
		name: "import { fetch, getJSON } from 'wix-fetch'",
		kind: 8,
		snippet: "{ ${1|fetch,getJSON|} } from 'wix-fetch';",
		docs: "An implementation of the standard Javascript Fetch API which can be used in public and backend code for fetching resources from 3rd party services using HTTPS.\n\n[wix-fetch](https://www.wix.com/velo/reference/wix-fetch)"
	},
	{
		name: "import wixData from 'wix-data'",
		kind: 8,
		snippet: "wixData from 'wix-data';",
		docs: "The [wix-data](https://www.wix.com/velo/reference/wix-data) module contains functionality for working with data in collections."
	}
];

const JSW = /(.+)src\/backend\/(.+)\.jsw$/;
const isBackend = path => JSW.test(path);
const isString = val => typeof val === 'string';
const createCompletionList = list => {
  return list.map(item => {
    const completion = new vscode.CompletionItem(item.name, item.kind);

    if (isString(item.snippet)) {
      completion.insertText = new vscode.SnippetString(item.snippet);
    }

    if (isString(item.detail)) {
      completion.detail = item.detail;
    }

    if (isString(item.docs)) {
      completion.documentation = new vscode.MarkdownString(item.docs);
    }

    return completion;
  });
};
const resolve = (...path$1) => {
  const folders = vscode.workspace.workspaceFolders;

  if (Array.isArray(folders)) {
    const [root] = folders;
    return path.join(root.uri.fsPath, ...path$1);
  }

  return '';
};

const common = createCompletionList(site);
const frontendList = createCompletionList(frontend).concat(common);
const backendList = createCompletionList(backend).concat(common);
const modules = {
  provideCompletionItems(doc, position) {
    const prefix = doc.lineAt(position).text.substring(0, position.character);

    if (/^import\s/.test(prefix)) {
      return isBackend(doc.uri.path) ? backendList : frontendList;
    }
  }

};

const getItems = async (match, isJSW) => {
  const items = [];
  const dir = match[1].split('/').slice(0, -1);
  const path$1 = resolve('src', ...dir);

  if (fs.existsSync(path$1)) {
    const ext = isJSW ? '.jsw' : '.js';
    const files = await promises.readdir(path$1);

    for (const name of files) {
      const filePath = path.join(path$1, name);
      const status = await promises.lstat(filePath);

      if (status.isDirectory()) {
        items.push({
          name,
          kind: 18
        });
      } else if (path.extname(name) === ext) {
        items.push({
          name: path.basename(name, ext),
          kind: 16,
          detail: name,
          docs: isJSW ? 'Velo Web Modules' : 'Public Files'
        });
      }
    }
  }

  return items;
};

const jsw = {
  async provideCompletionItems(doc, position) {
    const prefix = doc.lineAt(position).text.substring(0, position.character);
    const matchBack = /^(?:import.+['"])(backend\/.*)/m.exec(prefix);

    if (Array.isArray(matchBack)) {
      try {
        const items = await getItems(matchBack, true);
        return createCompletionList(items);
      } catch {
        /**/
      }
    }

    const mathcPub = /^(?:import.+['"])(public\/.*)/m.exec(prefix);

    if (Array.isArray(mathcPub)) {
      try {
        const items = await getItems(mathcPub, false);
        return createCompletionList(items);
      } catch {
        /**/
      }
    }
  }

};

const config = vscode.workspace.getConfiguration('velo.autocomplete', null);

const register = (provider, trigger) => {
  return vscode.languages.registerCompletionItemProvider({
    scheme: 'file',
    language: 'javascript'
  }, provider, trigger);
};

const getProviders = () => {
  const providers = [];

  if (config.get('import')) {
    providers.push(register(modules, ' '));
  }

  if (config.get('jsw')) {
    providers.push(register(jsw, '/'));
  }

  return providers;
};

function activate(context) {
  const providers = getProviders();
  context.subscriptions.push(...providers);
}

exports.activate = activate;
