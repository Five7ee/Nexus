# Manuel de montage 3D — Setup

Viewer web pour manuels de montage avec animations 3D interactives et QR codes.

---

## Structure du projet

```
assembly-viewer/
├── index.html          ← Page d'index avec QR codes (ne pas modifier)
├── view.html           ← Viewer 3D (ne pas modifier)
├── steps.json          ← ⭐ SEUL FICHIER À ÉDITER
├── models/             ← Déposer vos fichiers .glb ici
│   ├── etape-01.glb
│   ├── etape-02.glb
│   └── ...
└── images/             ← Photos des étapes pour l'index (optionnel)
    ├── etape-01.jpg
    └── ...
```

---

## Mise en route (5 min)

### 1. Créer un repo GitHub

1. Aller sur [github.com/new](https://github.com/new)
2. Nommer le repo (ex: `montage-projet-x`), cocher **Public**
3. Créer le repo

### 2. Uploader les fichiers

Glisser-déposer tous les fichiers dans l'interface GitHub :
- `index.html`, `view.html`, `steps.json`
- Dossier `models/` avec vos `.glb`
- Dossier `images/` avec vos photos (optionnel)

> ⚠️ Si vos GLB font > 100 MB, voir section "Fichiers lourds" ci-dessous.

### 3. Activer GitHub Pages

1. Repo → **Settings** → **Pages**
2. Source : **Deploy from a branch**
3. Branch : `main`, dossier : `/ (root)`
4. Sauvegarder

Votre site sera disponible en ~1 min à :
`https://VOTRE_USERNAME.github.io/NOM_DU_REPO/`

---

## Configurer vos étapes

Éditez uniquement `steps.json` :

```json
{
  "project": "Nom de votre projet",
  "description": "Description courte affichée sous le titre.",
  "steps": [
    {
      "id": "etape-01",
      "step": 1,
      "title": "Titre de l'étape",
      "description": "Description courte affichée sur la carte.",
      "model": "etape-01",
      "image": "images/etape-01.jpg"
    }
  ]
}
```

| Champ | Description |
|---|---|
| `model` | Nom du fichier GLB **sans extension** dans `models/` |
| `image` | Chemin de la photo pour la carte index (optionnel, supprimer le champ si absent) |
| `step` | Numéro affiché |

---

## Convertir un Alembic en GLB (Blender)

1. **Importer** : File → Import → Alembic (.abc)
2. Si simulation (cloth, fluide) : sélectionner le mesh → Object → Apply → Visual Geometry to Mesh pour chaque frame, ou utiliser l'export direct
3. **Exporter** : File → Export → glTF 2.0 (.glb)
   - Format : **GLB**
   - Cocher **Animation**
   - Cocher **Draco mesh compression** (réduit ~70% la taille)
4. Déposer le `.glb` dans `models/`

---

## Fichiers lourds (> 100 MB)

GitHub bloque les fichiers > 100 MB. Options :

**Option A — Git LFS** (simple, gratuit jusqu'à 1 GB)
```bash
git lfs install
git lfs track "*.glb"
git add .gitattributes
git add models/
git commit -m "Add models"
git push
```

**Option B — Hébergement externe**
Uploader les GLB sur [Cloudflare R2](https://r2.cloudflare.com) ou n'importe quel hébergement statique,
puis dans `steps.json` utiliser l'URL complète dans le champ `model` :
```json
"model": "https://pub-xxx.r2.dev/etape-01"
```
(Le `.glb` est ajouté automatiquement dans `view.html`)

> Pour l'option B, modifier ligne dans `view.html` :
> ```js
> viewer.src = `models/${modelId}.glb`;
> // → remplacer par :
> viewer.src = modelId.startsWith('http') ? modelId + '.glb' : `models/${modelId}.glb`;
> ```

---

## QR Codes

Les QR codes sont **générés automatiquement** à partir de l'URL de votre GitHub Pages.
Pour imprimer les cartes d'index avec les QR codes : Ctrl+P depuis le navigateur.

---

## Contrôles viewer (mobile & desktop)

| Action | Mobile | Desktop |
|---|---|---|
| Orbiter | Glisser 1 doigt | Clic gauche + glisser |
| Zoomer | Pincer | Molette |
| Panoramique | Glisser 2 doigts | Clic droit + glisser |
