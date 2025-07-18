
# Robot Framework Example Test For Ministry VWS Page

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

### Test uitvoeren:
Vanuit root van project:
```
robot --outputdir results tests/
```

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
