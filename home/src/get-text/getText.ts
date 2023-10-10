import { firefox } from "playwright";
import { Readability } from "@mozilla/readability";
import { JSDOM } from "jsdom";

async function getText(url: string) {
  const browser = await firefox.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto(url);
  const content = await page.content();
  const doc = new JSDOM(content, {
    url: url,
  });
  let reader = new Readability(doc.window.document);
  let article = reader.parse();
  console.log(article?.textContent);
  await browser.close();
}

if (process.argv.length !== 3) {
  console.log("Usage: get-text URL");
  process.exit(1);
}

getText(process.argv[2]);
