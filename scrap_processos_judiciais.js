// Web scraping dos processos judiciais das empresas: www.jusbrasil.com.br
// Usando nodejs e pupperteer para browser automação
// parametros: entra do arquivo de empresas em CSV
// e output de csv com a empresa e numero de processos.


const puppeteer = require("puppeteer"); // importe o pacote puppeteer
const fs = require("fs"); 
 
let scrape = async () => { // crie uma função assíncrona que irá realizar o scraping
  const browser = await puppeteer.launch({
    headless: false,
  }); // cria um browser. A propriedade headless define se o browser irá abrir com interface gráfica ou se apenas irá executar em segundo plano, sem GUI. false = irá abrir interface gráfica; true = não irá abrir interface gráfica
 
  var data = fs.readFileSync("empresas.csv", "utf8",)
  data = data.split("\n")
  
  for (let i in data) { 
  
 
  const page = await browser.newPage(); // cria uma nova aba no navegador acima
  
   var empresa;
   console.log(data[i]) 
   empresa = data[i];
 
   await page.setDefaultNavigationTimeout(0); 
   await page.goto("https://www.jusbrasil.com.br/busca?q=" + empresa , {
    waitUntil: 'load',
    // Remove the timeout
    timeout: 0
  });
  
  
  await page.goto("https://www.jusbrasil.com.br/busca?q=" + empresa);
  

   await page.waitForSelector('div.SearchFeaturedLawsuit-snippet-description')
   var element = await page.$('div.SearchFeaturedLawsuit-snippet-description')
   var value = await page.evaluate(el => el.textContent, element)
  

  fs.writeFile('procs.txt', data[i] + ';' + value + "\n",  {'flag':'a'},  function(err) {
    if (err) {
        return console.error(err);
    }
  });
 
  }
  
  browser.close(); // fecha o browser, indicando que finalizamos o scraping

  return []; // no momento, não desejamos retornar nada. Por isso, return []
};
 
 
//chamada da função scrape. O then/catch é para esperar que a função assíncrona termine e para que possamos tratar eventuais erros. 
scrape()
  .then((value) => {
    
  })
  .catch((error) => console.log(error));