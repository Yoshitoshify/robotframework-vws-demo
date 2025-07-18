
# Robot Framework VWS Browser Test Project

Dit project bevat een geavanceerd voorbeeld voor browser automatisering met Robot Framework, gebruikmakend van het Page Object Model, custom locators, en PDF-vergelijking.

## Installatie

1. Zorg ervoor dat Python 3.7+ is geïnstalleerd
2. Installeer de vereiste packages:
   ```
   pip install -r requirements.txt
   ```

## Project Structuur

```
robotFrameworkVoorbeeld/
├── requirements.txt
├── tests/
│   └── vws_example_test.robot         # Hoofdtest voor VWS demo
├── resources/
│   └── page_object/
│       ├── keywords/
│       │   ├── common.robot           # Herbruikbare en suite-brede keywords
│       │   ├── rijksoverheid_home_page.robot
│       │   ├── ministries.robot
│       │   ├── VWS_home_page.robot
│       │   └── VWS_search.robot
│       ├── locators/
│       │   └── locators.py            # Python file met alle page object locators
│       └── tools/
│           └── extract_pdf_text.py    # PDF tekst extractie script
├── results/                          # Test resultaten en screenshots
```

## Tests Uitvoeren

### Alle tests uitvoeren:
```
robot --outputdir results tests/
```

### Specifieke test file uitvoeren:
```
robot --outputdir results tests/vws_example_test.robot
```

## Belangrijkste Testcase

### Test Demo Ministry VWS pdf comparison
- Navigeert naar rijksoverheid.nl
- Gaat via het menu naar Ministeries > VWS
- Voert een zoekopdracht uit
- Opent een zoekresultaat (PDF rapport)
- Downloadt de PDF en vergelijkt de tekst met een baseline PDF

Zie `tests/vws_example_test.robot` voor het volledige scenario.

## Page Object Model & Locators

- Keywords zijn gescheiden per pagina in `resources/page_object/keywords/`
- Locators worden centraal beheerd in `resources/page_object/locators/locators.py` (Python variabelen)
- Herbruikbare logica (zoals browser setup, PDF-vergelijking) staat in `common.robot`

## PDF Vergelijking

Het keyword `Compare Downloaded PDF With Baseline` vergelijkt de tekst van een gedownloade PDF met een baseline PDF. Hiervoor wordt een Python script gebruikt (`extract_pdf_text.py`).

## Suppress Warnings

- Chrome logging en InsecureRequestWarning worden automatisch onderdrukt in de keywords.

## Tips

1. **Screenshots**: Bij gefaalde tests worden automatisch screenshots gemaakt in `results/screenshots`
2. **Herbruikbare Keywords**: Gebruik keywords uit `common.robot` en de page object keyword files
3. **Locators**: Beheer selectors centraal in `locators.py` voor onderhoudbaarheid
4. **Output**: Alle testresultaten komen in de map `results/`
5. **Page Object Pattern**: Voor overzicht en onderhoudbaarheid
