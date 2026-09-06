# Start here — first-time setup

One-time only. About 20 minutes, most of it waiting for downloads. After this, publishing an
update is two clicks.

Everything below is already filled in with your username (`juanmasacova`) and repository name
(`AGUILA-UAV`). There is nothing to find-and-replace.

---

## What you're actually setting up

Three things, and it helps to know which is which:

| Thing | What it is | Where it lives |
|---|---|---|
| **The folder** | The real files, on your computer | `Escritorio\AGUILA` |
| **The repository** | A copy on GitHub, with the full history of every change | github.com/juanmasacova/AGUILA-UAV |
| **The site** | A website built automatically from the folder | juanmasacova.github.io/AGUILA-UAV |

You work in the folder. GitHub Desktop copies your changes up to the repository. GitHub then
builds the site from them, by itself, every time. You never touch the site directly.

The word **commit** means "save a snapshot with a note about what changed." The word **push**
means "send my commits to GitHub." That's the whole vocabulary.

---

## Step 1 — Put the files in place

1. In `C:\Users\juanm\OneDrive\Escritorio\AGUILA`, right-click `AGUILA-repo.zip` →
   **Extract All…**
2. When it asks where, it will suggest a subfolder called `AGUILA-repo`. **Delete that last part**
   so the path is just `C:\Users\juanm\OneDrive\Escritorio\AGUILA` — you want the contents going
   directly into the AGUILA folder, not into a subfolder inside it.
3. Click **Extract**.
4. **Delete the `00_Program` folder.** Those two documents now live at
   `docs\program\revisions\`, and having two copies is exactly the kind of thing that gets
   confusing in three months.
5. **Delete `AGUILA-repo.zip`.** You've extracted it; keeping it would upload a copy of the
   project inside the project.

Your AGUILA folder should now look like this:

```
AGUILA\
  analysis\
  cad\
  docs\
  firmware\
  includes\
  internal\
  .github\          ← may be hidden; that's fine, leave it alone
  .gitignore        ← may be hidden; that's fine
  HOW_TO_UPDATE.md
  LICENSE
  README.md
  requirements.txt
  START_HERE.md
  mkdocs.yml
```

!!! note "If you don't see `.github` or `.gitignore`"
    Windows hides files starting with a dot. In File Explorer: **View → Show → Hidden items**.
    They're there either way and they matter — `.github` is what builds your site.

---

## Step 2 — Check the exact repository address, then clear it

### 2a. Confirm the address

You named it "AGUILA UAV" with a space. GitHub does not allow spaces in addresses, so it silently
converted it — almost certainly to `AGUILA-UAV`.

**Verify before going further.** Open your repository on github.com and look at the address bar.
It should read:

```
https://github.com/juanmasacova/AGUILA-UAV
```

If the last part is anything other than `AGUILA-UAV` — say `AGUILA_UAV` or `aguila-uav` — tell me
and I will regenerate the files. Every link in the project points at this address, so it needs to
be right. (Nothing breaks if it is wrong; the site still builds. The links in the page header just
go nowhere.)

### 2b. Delete the empty repository

This feels backwards, so here is the reason: GitHub Desktop's **Publish** button *creates* the
repository for you, and refuses if one already exists with that name. Your repository has nothing
in it, so nothing is lost by deleting it — you are removing an empty container, not any work.

1. Go to **github.com/juanmasacova/AGUILA-UAV**
2. **Settings** — the tab along the top of the repository, not your account settings
3. Scroll to the very bottom, **Danger Zone** → **Delete this repository**
4. Type the name when prompted to confirm

You will recreate it under the same name in Step 5, with all your files in it.

??? question "I would rather keep the repository I already made"
    Reasonable. Do this instead:

    1. Complete Step 4 as written (this makes the folder a local repository)
    2. Commit, as in Step 5 step 1–2 — but **do not** click Publish
    3. Menu bar: **Repository → Repository settings…**
    4. In the **Remote** section, set the URL to
       `https://github.com/juanmasacova/AGUILA-UAV.git` and Save
    5. Click **Push origin** at the top

    If there is no Remote section in that dialog, your version of GitHub Desktop does not offer
    it for unpublished repositories — delete the empty repository and publish normally instead.

## Step 3 — Install GitHub Desktop

1. Download from **[desktop.github.com](https://desktop.github.com)**
2. Install and open it
3. **File → Options → Accounts → Sign in** to your GitHub account

That sign-in is the only authentication you'll ever set up. GitHub Desktop remembers it.

---

## Step 4 — Turn the folder into a repository

1. In GitHub Desktop: **File → Add local repository…**
2. **Choose…** and select `C:\Users\juanm\OneDrive\Escritorio\AGUILA`
3. It will say *"This directory does not appear to be a Git repository."* — this is expected.
   Click the blue link that says **create a repository**
4. A dialog opens with the path already filled in. Change **Name** to `AGUILA-UAV`
5. Leave everything else alone — do **not** tick "Initialize with a README", and leave Git ignore
   and License as None. You already have all three
6. Click **Create repository**

GitHub Desktop now shows about 40 files in the **Changes** panel on the left. That's your project,
staged and ready.

!!! tip "Check that `internal/` is *not* in the list"
    It shouldn't be. That folder is deliberately excluded so you have somewhere to keep rough
    notes, supplier quotes and half-formed ideas that never get published. If you see it listed,
    the `.gitignore` file didn't extract — say so and I'll fix it.

---

## Step 5 — First commit and publish

1. Bottom-left, in the **Summary** box, type:
   `Initial commit: Rev 0.2 MVP definition, analysis, and documentation site`
2. Click **Commit to main**
3. Top of the window, click **Publish repository**
4. In the dialog:
   - **Name:** `AGUILA-UAV`
   - **Description:** optional
   - **Keep this code private** — ⚠️ **UNTICK THIS.** It's ticked by default. GitHub Pages is
     free only on public repositories, and a private portfolio isn't a portfolio
5. Click **Publish repository**

Your code is now on GitHub. Go look at github.com/juanmasacova/AGUILA-UAV — it should all be there.

---

## Step 6 — Switch the site on

The site doesn't build until you tell GitHub to allow it. One time only.

1. **github.com/juanmasacova/AGUILA-UAV** → **Settings** tab
2. Left sidebar → **Pages**
3. Under **Build and deployment → Source**, change **Deploy from a branch** to
   **GitHub Actions**
4. That's it — no Save button, it applies immediately

Now trigger a build:

1. **Actions** tab → click **Build and deploy documentation site** in the left sidebar
2. **Run workflow** button on the right → **Run workflow**
3. Wait about 90 seconds. A yellow dot means running, green tick means done

Your site is live at **[juanmasacova.github.io/AGUILA-UAV](https://juanmasacova.github.io/AGUILA-UAV/)**.

First deploy sometimes takes a couple of extra minutes for DNS. If you get a 404, wait three
minutes and reload before assuming anything is broken.

---

## Step 7 — Prove the loop works

Worth doing once so you trust it.

1. Open `docs\index.md` in any text editor (Notepad works; VS Code is nicer)
2. Change a word somewhere — anything
3. In GitHub Desktop: type a summary like `Test: confirm the publish loop`, click
   **Commit to main**, then **Push origin**
4. Watch the **Actions** tab. Green tick in about 90 seconds
5. Reload your site. The change is there

That's the entire ongoing workflow: edit → commit → push. See
[HOW_TO_UPDATE.md](HOW_TO_UPDATE.md) for what to edit when.

---

## Optional — preview the site on your own machine

Not required. GitHub builds the site whether or not you can. But if you'd rather see changes
before publishing them:

1. Install Python from **[python.org/downloads](https://www.python.org/downloads/)** — **tick
   "Add Python to PATH"** on the first screen of the installer, it's easy to miss
2. Open **Command Prompt** and run:

```
cd C:\Users\juanm\OneDrive\Escritorio\AGUILA
pip install -r requirements.txt
mkdocs serve
```

3. Open **http://127.0.0.1:8000** in your browser. It reloads as you save files
4. `Ctrl+C` in the Command Prompt to stop

You also need Python for `python analysis\make_tables.py`, which is what regenerates the
numbers when you change a design parameter. If you skip Python entirely, just don't edit
`analysis\aguila.py` — the build will reject it if the tables don't match.

---

## Things that will go wrong, and what they mean

**Red X on the Actions tab.** Click into it and read the error.

- *"includes/ is stale"* — you edited `analysis/aguila.py` without regenerating. Run
  `python analysis\make_tables.py`, then commit and push again. This is the guard working
  correctly: it's stopping you publishing numbers that disagree with your own analysis.
- *"mkdocs build --strict failed"* — usually a link to a page that doesn't exist, or a new page
  added to `docs\` without being listed in `nav:` in `mkdocs.yml`. The error names the file.

**GitHub Desktop says a file is locked or permission denied.** OneDrive is syncing. Right-click
the OneDrive cloud icon in your taskbar → **Pause syncing → 2 hours**, retry, then resume.

**Site shows 404 after Pages is configured.** Give it three minutes. If it persists, check the
Actions tab actually shows a green **deploy** job, not just a green **build** job.

**You committed something you didn't mean to.** Nothing is ever really lost in git. Ask before
trying to fix it yourself — the recovery is easy, but the commands that *look* right are often
the destructive ones.

---

## About the Claude project

Separate from GitHub, and worth knowing since you asked.

This conversation is attached to a Claude project called **UAV - AGUILA**. Both revision documents
are saved there. That means any new conversation you start inside that project already has the
context — you don't need to re-explain the aircraft, the constraints, or the decisions.

Practical version: when you come back to work on this, start the chat from inside the UAV - AGUILA
project rather than a blank one. Ask for "the tilt-wing" and it'll know what you mean.

The two are independent. GitHub is the permanent public record; the Claude project is working
context. Neither one updates the other automatically.
