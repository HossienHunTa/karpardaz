import { serve } from 'https://deno.land/std@0.177.0/http/server.ts';
import { Builder, Browser, By, Key, until } from 'https://esm.sh/selenium-webdriver/';
import "https://esm.sh/chromedriver";


(async function helloSelenium() {
  let driver = await new Builder().forBrowser('chrome').build();

  await driver.get('https://selenium.dev');

  await driver.quit();
})();

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey',
}

serve(async (req: Request) => {
  const { url, method } = req
  const u=new URL(url);
  const creditCardNumber = u.searchParams.get('test');
  if (method === 'OPTIONS') {
    return new Response()
  }
})