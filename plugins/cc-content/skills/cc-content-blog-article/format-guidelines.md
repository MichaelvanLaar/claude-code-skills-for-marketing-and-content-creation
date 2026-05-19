# Blog Article Format Guidelines

Format-scope rules for the `cc-content-blog-article` skill. These rules are language-
and industry-neutral: they describe **structure, calibration, and persuasion architecture**,
not voice or vocabulary. Voice comes from the loaded `writing-style` context; output
language comes from the loaded `content-defaults` context. All word counts in this file
are **English-equivalent units** — translate proportionally for other languages (German
typically +10–20%, Romance languages roughly equivalent, CJK languages count characters
instead, where ~1.6 CJK characters ≈ 1 English word).

The guidelines are organized in three layers:

- **Layer 1 — Universal best practices.** Apply to every blog article.
- **Layer 2 — Audience-specific variations.** B2B/B2C divergence + persuasion stack.
- **Layer 3 — Goal, funnel, and expertise variations.** The three calibration axes.

A run-time **quality checklist** at the end summarizes the gates every draft must pass.

---

## Layer 1 — Universal Best Practices

These apply to every blog article regardless of audience, goal, channel, or language.

### Length and scope

There is no universal "right length." Length is a function of **search intent and content
type**, and depth should always beat padding. The defensible defaults below are starting
points — deviate when intent demands it, never to hit an arbitrary target.

| Content type                       | Working length range | Length driver                                    |
| ---------------------------------- | -------------------- | ------------------------------------------------ |
| "What is X" / definitional         | 1,300–1,700 words    | Featured-snippet optimization; low intent depth  |
| How-to / tutorial                  | 1,500–3,000 words    | Step completeness; screenshots; example coverage |
| Listicle                           | 2,000–2,600 words    | Item depth; scannability                         |
| Comparison ("X vs. Y" / category)  | 2,000–3,000 words    | BOFU evaluation completeness                     |
| Pillar / ultimate guide            | 3,500–7,000+ words   | Topic coverage; serves as internal-link hub      |
| POV / thought leadership / opinion | 800–1,800 words      | Argument density over comprehensiveness          |
| News / trend commentary            | 600–1,200 words      | Timeliness                                       |
| Newsletter version of a blog post  | 400–900 words        | Single-focus; inbox context                      |
| Retention / customer success       | 800–2,000 words      | Task scope                                       |

Two facts the literature supports unambiguously:

- **Word count is not a Google ranking factor.** Correlations between length and traffic
  reflect topic coverage, not character count. Length earns reach only when each
  paragraph adds something the reader cannot find elsewhere.
- **Depth disproportionately wins.** Across Orbit Media, HubSpot, Semrush, and Backlinko
  studies, the minority of teams who invest 6+ hours per article and push past 2,000 words
  report "strong results" at roughly 1.7–1.9× the baseline rate. The takeaway is not
  "always go long" — it is "go long only when you can sustain depth at length."

When in doubt, ask: _can every sentence in this draft survive a "so what?" challenge?_
If not, the article is too long, not too short.

### Required sections

A defensible default structure has **six functional zones**, each with one job. The
sections may be re-titled, merged, or expanded — but every job must be performed.

1. **Headline (H1).** The primary conversion point _before_ the article begins. It must
   promise specific value, name an entity or number where possible, and earn the click.
   List-format headlines and how-to / question-style headlines empirically over-perform
   on traffic and backlinks. Posts with 14+ word headlines historically out-share short
   ones — but a vague long headline still loses to a sharp short one.
2. **Hook / introduction (first 50–200 words).** Earns the scroll past the fold. States
   who the post is for, what it covers, and why it matters — in the reader's language.
3. **Context / problem definition.** Establishes shared understanding before introducing
   solutions. Answers "why does this matter now?"
4. **Body, divided by descriptive H2s.** Delivers the substance using a recognizable
   framework (AIDA, PAS, BAB, FAB, 4Ps, StoryBrand, JTBD — see the
   `storytelling-frameworks.md` shared reference).
5. **Proof inserts.** Statistics, named case studies, expert quotes, original data,
   screenshots, diagrams — **distributed throughout, not clumped at the end**.
6. **Conclusion + CTA.** The conclusion synthesizes — it does not summarize. It offers
   a re-frame, a forward implication, or a next-step insight. The CTA is **singular**
   and stage-appropriate.

A blog post that cannot identify which paragraph performs each job is structurally
unsound, regardless of how well it is written.

### Hook / opening

Four mechanisms dominate hook performance:

- **Curiosity gap (Loewenstein, 1994):** Name a specific gap in the reader's knowledge
  and a partial answer. _Specific_ is the load-bearing word: "We cut churn 47% — and one
  tactic did most of the work" works; "You won't believe what happened next" does not.
- **Problem-agitation (PAS opener):** Lead with a sharply named pain the reader
  recognizes within five seconds.
- **Surprise / pattern interrupt:** Open with a counterintuitive statistic or claim
  that violates a default belief.
- **Specificity:** Named entities, dollar figures, dates, proper nouns. "Stripe's billing
  team cut..." beats "A leading fintech company cut..." every time.

Nielsen Norman Group research puts the stay-or-leave decision at **10–20 seconds**.
The hook is load-bearing, not stylistic. The first paragraph must explicitly tell the
scanner what they will gain by continuing.

**Anti-patterns to avoid in openers:**

- "I'm excited to share…", "In today's fast-paced world…", "Everyone knows that…"
- Definitional preambles ("Marketing is the practice of…") before the actual hook
- Apologies, throat-clearing, or résumé-style author introductions
- Generic clickbait ("This will blow your mind") with no concrete gap defined

### Call to action

Three findings dominate the CTA literature and translate directly to blog posts:

1. **Single CTAs convert dramatically better than competing ones.** Have **one primary
   CTA per post**, repeated at multiple scroll depths, rather than multiple competing
   offers. Inline links to related reading are fine — they are not CTAs.
2. **Placement matters less than ubiquity.** Seed the same primary CTA at **three
   positions**: after the intro (~20% depth), mid-post (~60–70% depth, after a key
   insight is delivered), and at the conclusion. This beats betting on a single position.
3. **Buttons beat text; specific beats generic; first-person beats second-person.**
   "Start _my_ trial" outperforms "Start _your_ trial" outperforms "Learn more."
   Outcome language ("Download the checklist") beats subscription language ("Subscribe").

Match CTA directness to funnel stage (see Layer 3): a "Request a demo" CTA on an
awareness post is the most common single failure mode in content programs.

### Formatting conventions

Nielsen Norman Group's research is unambiguous: **users read only 20–28% of words on
an average page; 79% scan, only 16% read word-by-word.** The dominant scanning pattern
on text-heavy pages is the **F-pattern** (eye drops down the left edge); the most
effective scanning aid is the **"layer-cake" pattern** — eyes jumping from heading to
heading — which only works when subheads are descriptive and visually distinct.

Concrete formatting rules:

- **Paragraphs of 1–3 sentences** for body copy; up to 4 in dense reference sections.
  Front-load the information-carrying word.
- **Descriptive H2 subheads every 250–350 words.** Avoid clever or punny subheads — the
  layer-cake breaks if H2s don't telegraph their section's content. H3s only when there
  is genuine hierarchy.
- **Bullets and bolded keywords** to enable the "spotted" pattern. Bold the **1–3 most
  important claims per section**, not full sentences and not decorative bolding.
- **One image per ~300–400 words** as a working default. Original diagrams, annotated
  screenshots, and data visualizations outperform stock photography (picture-superiority
  effect; Paivio & Csapo, 1973). All images need descriptive alt text.
- **Numerals over spelled-out numbers** in headlines and lists ("23 ways" out-scans
  "twenty-three ways").
- **Generous white space.** Density should be high _within_ paragraphs and low
  _between_ them.
- **Single H1, descriptive H2/H3 nesting.** Required for SEO and for paragraph-snippet
  optimization (a 40–60-word direct answer near the top wins many featured snippets).
- **Mobile-first defaults.** 58–64% of global web traffic is mobile (StatCounter).
  Minimum 16px font size, 44px+ touch targets, single-column layouts, even shorter
  paragraphs.

### What separates high- from low-performing content

The literature converges on five attributes that explain most of the variance:

1. **Originality of point of view.** A defended POV beats encyclopedic neutrality.
   Animalz's blunt framing: "AI has exposed the cheapness of content that was always
   cheap — copycat content."
2. **Depth over breadth.** Time invested per article is one of the strongest predictors
   of "strong results" in the Orbit Media annual blogger surveys.
3. **Original data, primary research, or proprietary perspective.** Cited by 55% of
   Edelman/LinkedIn 2024 respondents as the top driver of thought-leadership quality.
4. **Expertise signals (E-E-A-T: Experience, Expertise, Authoritativeness, Trust).**
   Named authors with credentials, first-hand experience disclosures, citations to
   reputable sources.
5. **Specificity.** Named entities, exact numbers, concrete scenarios.

Low-performing content shares the opposite traits: vague headlines, wall-of-text
paragraphs, no descriptive subheads, third-hand statistics, multiple competing CTAs,
and no defended POV.

---

## Layer 2 — Audience-Specific Variations

### B2B vs. B2C divergence

The B2B/B2C split is best understood as **a difference in who reads, why, with whom,
and against what stakes** — not as a difference in topic or industry. Every surface
divergence below traces back to a behavioral root cause.

| Dimension              | B2B default                                                       | B2C default                                              | Underlying reason                                                                                 |
| ---------------------- | ----------------------------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| Typical length         | 1,800–3,000 words for substantive posts                           | 600–1,500 words                                          | Higher stakes; content must satisfy multiple stakeholders; longer evaluation window               |
| Buying cycle           | 6–18 months (enterprise); ~3 months (SMB)                         | Hours to weeks                                           | Drives need for sustained nurture content vs. single conversion event                             |
| Primary tone           | Rational frame with emotional undercurrent                        | Emotional frame with rational support                    | Buyers protect professional credibility; emotional B2B builds long-term brand (Binet & Field ~7×) |
| Evidence stack         | Data, named case studies, analyst citations, original research    | Storytelling, reviews, influencer / celebrity, lifestyle | B2B buyers carry career risk; B2C buyers carry personal preference risk                           |
| Reading context        | Work hours, intent-driven, problem-aware                          | Leisure, discovery-driven, browse mode                   | Determines tolerance for density and length                                                       |
| Decision unit          | 6–13 stakeholders, multi-function (Gartner, Forrester)            | 1 individual, sometimes a couple / household             | Content must be forwardable, screenshottable, multi-persona                                       |
| Primary CTAs           | Demo, talk to sales, download whitepaper, webinar, ROI calculator | Buy now, add to cart, subscribe, sign up free            | Reflects cycle length and information appetite                                                    |
| Self-directed research | ~70%+ of journey before vendor contact (6sense, 2025)             | Variable; often shorter                                  | Forces content to do the qualifying work historically done by reps                                |
| Top persuasion levers  | Authority > social proof > reciprocity                            | Social proof > liking / unity > scarcity                 | Differential trust and risk anchors                                                               |

Two findings deserve emphasis because they are commonly misunderstood:

- **The "B2B should be drier than B2C" assumption is backwards at the brand layer.**
  Binet & Field's IPA analysis applied to B2B shows emotional messaging dominates
  long-term effectiveness in both modes. B2B rational specifics win short-term
  activation; emotional brand-building wins long-term growth.
- **"Fear of blame is more potent than fear of regret" in B2B** (Rory Sutherland).
  B2B buyers protect their professional credibility, so risk reduction, peer-similarity
  proof, and decision defensibility consistently out-perform aspiration framing.

#### B2B sub-variations

The "B2B" label hides two divergences that change content design materially:

- **SMB vs. enterprise.** SMB deals close in 30–90 days, often with a single
  owner-operator decision-maker, and reward concise ROI-clear content, free trials, and
  peer reviews. Enterprise deals stretch 6–18 months, require multi-stakeholder content
  (technical white papers, security / compliance documentation, analyst validation,
  named-customer case studies at scale), and tolerate longer, denser assets.
- **Technical buyer vs. executive sponsor.** Technical buyers (CTO, IT lead, security
  lead) evaluate feasibility, integration, and implementation risk — vocabulary is
  features, specs, APIs, certifications. Executive sponsors own budget and approve
  spend — vocabulary is outcomes, payback period, strategic alignment. **Serve both
  audiences in the same asset wherever possible** (technical detail in expandable
  sections or appendices; business-outcome narrative in the lead and conclusion) rather
  than fragmenting into per-persona variants that never reach the full committee.

### Persuasion principles applied to blog content

This is a brief, format-specific overlay. The full operational guidance lives in the
shared reference `persuasion-principles.md`, which the skill imports at runtime.

| Principle                       | Strongest in           | Blog-specific implementations                                                                                                                                                                                                                      |
| ------------------------------- | ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Authority                       | B2B (highest leverage) | Author bylines with credentials; original research; named-analyst citations (Gartner, Forrester); methodology disclosures; named expert interviews                                                                                                 |
| Social proof                    | B2C (highest leverage) | Named-customer case studies with quantified outcomes; logo bars near CTAs; specific reader counts; embedded practitioner quotes; "as featured in" badges                                                                                           |
| Reciprocity                     | Both                   | Ungated, immediately usable substantive resources (templates, calculators, original benchmarks). Gate value only when it is genuinely exclusive or hard to produce                                                                                 |
| Loss aversion + status quo bias | BOFU (both)            | Avoidance-framed headlines; explicit cost-of-inaction framing; risk-reversal CTAs (free trial, money-back); migration ease tables; one strong loss frame beats sustained catastrophizing                                                           |
| Curiosity gap                   | Hook universal         | Headlines naming a specific gap + partial answer; promised payoffs in the lead; "open loops" that resolve in later sections; subheads posing unanswered questions                                                                                  |
| Commitment / consistency        | Nurturing, retention   | Self-assessment quizzes; maturity-model scorecards; embedded polls; progressive disclosure CTAs ("Yes, send me part 2"); IKEA-effect calculators (reader builds their own output)                                                                  |
| Scarcity                        | B2C heavy; B2B narrow  | Real registration deadlines; honest cohort caps with visible seat counts; pilot caps. **Manufactured scarcity is the single most damaging failure mode** — countdown timers that reset and perpetual "limited" badges erode credibility measurably |
| Liking / unity                  | Brand-voice layer      | Consistent narrator; first-person voice with personality; "For [specific identity]" headers; "we / our" community language; insider terminology as belonging marker                                                                                |

**Cognitive biases with direct blog applications:** anchoring (open with a high reference
statistic that frames the post), framing effect (choose the frame that matches the goal —
"92% success rate" vs. "1 in 10 fail"), availability heuristic (vivid named examples
beat abstract ones), endowment effect ("your" framing — your dashboard, your audit,
your draft).

**Editorial governance:** manufactured scarcity, fabricated proof, and authority-as-name-dropping are the three failure modes that destroy credibility fastest. Govern them by
editorial policy, not by writer discretion.

---

## Layer 3 — Goal, Funnel, and Expertise Variations

Three independent calibration axes. Every blog article should declare its value on all
three before drafting begins; the most common cause of underperforming content is mixing
incompatible values inside a single post (e.g., a TOFU awareness post with a BOFU "Book
a demo" CTA).

### By content goal

| Goal               | Length / depth                                                 | Proof type                                                                                                         | CTA directness                            | Promotional density  |
| ------------------ | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------- | -------------------- |
| Thought leadership | 800–1,800 words; argument density over breadth                 | Original research, proprietary data, defended POV, explicit disagreement                                           | None to soft (subscribe, related read)    | Near zero            |
| Awareness          | 1,300–2,600 words; depends on intent                           | Third-party stats, accepted frameworks, industry benchmarks                                                        | Soft (newsletter, related read)           | Low                  |
| Lead generation    | 1,500–2,500 words; gated asset is the unlock                   | Mid-funnel proof types; previews of the gated asset's data                                                         | Medium ("Download the template")          | Low to medium        |
| Nurturing          | 600–1,500 words                                                | Practitioner perspectives, peer stories, contextual case studies                                                   | Soft (next-in-sequence, deeper resource)  | Low                  |
| Conversion         | 1,500–3,000 words for comparison; shorter for product-specific | Named-customer case studies with quantified outcomes; ROI calculators; pricing transparency; security / compliance | Hard ("Demo", "Trial", "Talk to sales")   | High and appropriate |
| Retention          | Task-dependent (800–2,000+ words)                              | Documentation depth; customer workflows; advanced playbooks                                                        | Zero-promotional (deeper docs, community) | Near zero            |

A critical caveat for **lead generation**: Demand Gen Report's 2024 data shows 51% of
B2B buyers find vendor content "too generic and irrelevant." Gate only content that is
genuinely exclusive, hard-to-produce, or interactive (original research, calculators,
substantive interactive assets). Rebranded checklists do not justify a gate.

**Framework fit by goal:** AIDA for awareness; PAS or BAB for lead-gen and MOFU; PAS, FAB, and 4Ps for conversion; StoryBrand for case studies and nurture; JTBD as a topic-selection lens across all goals. See the shared `storytelling-frameworks.md` for selection.

### By funnel stage (TOFU / MOFU / BOFU)

| Dimension            | TOFU (Awareness)                                      | MOFU (Consideration)                                               | BOFU (Decision)                                                      |
| -------------------- | ----------------------------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------- |
| Reader mindset       | Curious, learning, symptom-aware                      | Solution-aware, evaluating approaches                              | Vendor-aware, justifying choice                                      |
| Vocabulary           | Broad, symptom-level, layperson                       | Category and methodology terms                                     | Vendor / product-specific, feature- and price-level                  |
| Claim specificity    | General best practices, third-party stats             | Specific approaches, methodologies, case patterns                  | Specific product proof points, named-customer ROI                    |
| Proof type           | Industry data, accepted frameworks                    | Case studies, expert validation, methodologies                     | Named-customer testimonials, ROI numbers, security / compliance docs |
| Time budget          | Minutes; scanning dominates                           | 15–60 minutes; reading + scanning                                  | Deep evaluation; significant time tolerated                          |
| Format fit           | Short-form articles, infographics, definitional posts | Webinars, e-books, comparison guides, case studies                 | Demos, comparison pages, pricing, ROI calculators, trial signups     |
| CTA directness       | Soft — subscribe, follow, read related                | Medium — download, register, assessment                            | Hard — demo, trial, talk to sales, buy                               |
| Promotional density  | Near zero                                             | Low to medium                                                      | High                                                                 |
| Typical length       | 1,000–1,800 words                                     | 1,500–2,500 words                                                  | 1,500–3,000 words + deep proof assets                                |
| Effective frameworks | AIDA, JTBD for topic                                  | PAS, BAB, FAB                                                      | PAS, FAB, 4Ps, StoryBrand (for case studies)                         |
| Common mistake       | Pitching the product; gating awareness content        | Skipping the stage entirely (~65% of programs over-invest in BOFU) | Vagueness; missing proof; single-stakeholder framing in B2B          |

CMI's 2025 data underlines how widespread mis-alignment is: only **35% of B2B marketers
say their content aligns with the buyer's journey**. The cheapest audit lever — for
every article, declare its stage explicitly in the brief — eliminates most stage-mismatch
failures before they reach the draft.

### By audience expertise

| Dimension            | Novice                                                                                                          | Familiar (largest cohort in most B2B audiences)                            | Expert                                                                                                                                   |
| -------------------- | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Vocabulary           | Plain language; all terms defined on first use; no abbreviations                                                | Domain terms used freely; jargon explained inline only when niche-specific | Full technical vocabulary; no simplifications that sacrifice accuracy                                                                    |
| Background depth     | High — 3–4 paragraphs of context before methodology                                                             | Compressed — 1–2 paragraphs at most                                        | Minimal — jump into substance; experts feel insulted by over-explanation                                                                 |
| Credibility signals  | Named credentials, recognizable brand names, simple statistics                                                  | Frameworks, original data, named practitioners (Gartner, Forrester)        | Primary sources, code, specs, methodology disclosures, raw data, named acknowledgment of prior art                                       |
| Content density      | Low — one new concept per paragraph; explicit recaps                                                            | Moderate to high — two-to-three new ideas per paragraph                    | Maximal — every paragraph must carry an insight                                                                                          |
| Tone                 | Warm, reassuring, "this is simpler than it looks"                                                               | Peer-to-peer with explicit point of view                                   | Peer-of-peer; disagreement and uncertainty welcomed                                                                                      |
| Effective principles | Availability heuristic (vivid named examples), picture superiority, commitment / consistency (small first wins) | Authority (named experts, original research), anchoring, curiosity gap     | Authority through specificity, unity (in-group vocabulary as belonging marker). **Social proof and scarcity lose power** at expert level |

A practical test: if a novice reader can complete the post without Googling a term, **and**
an expert reader does not feel patronized in the same paragraph, the calibration is
correct. Most posts cannot serve all three expertise levels — **declare the target level
explicitly in the brief**. It is the cheapest editorial decision available.

**The Curse of Knowledge** is one of the most common failure modes in blog content:
experts forget what it felt like not to know something. Edit specifically to remove
unwarranted assumptions about baseline knowledge.

**Mixed-audience strategy:** when the audience genuinely spans expertise levels (common
when both practitioners and executives read the same post), apply the **inverted-pyramid
principle**: lead with the conclusion and most important insight; deliver supporting
detail in descending layers. Novices and executives take the headline and first section;
practitioners and experts continue for the depth.

---

## Quality Checklist

Every draft must pass these gates before it is presented to the owner.

### Structural

- [ ] Headline is specific, promises value, and contains the primary keyword (if SEO is a
      goal) — and survives "would I click this?"
- [ ] Hook (first 50–200 words) names a specific gap, problem, or surprise — no
      throat-clearing, no résumé-style author intro
- [ ] Six functional sections are present (headline → hook → context → body → proof
      inserts → conclusion + CTA), even if re-titled or merged
- [ ] H2 every 250–350 words; H2s are descriptive, not clever
- [ ] Paragraphs 1–3 sentences; layer-cake scanning works (eyes can follow the
      argument by reading only H2s)
- [ ] One primary CTA, repeated at ~20%, ~60–70%, and conclusion scroll depths
- [ ] CTA matches the post's stated funnel stage (no "Book a demo" on awareness posts)
- [ ] Proof inserts are distributed, not clumped — every major claim has supporting
      evidence within ~150 words

### Calibration

- [ ] Audience type (B2B / B2C; sub-variant if B2B), goal, funnel stage, and expertise
      level were explicitly inferred and confirmed with the owner before drafting
- [ ] Length falls within the working range for the chosen content type — or deviation
      is intentional and the rationale is documented
- [ ] Vocabulary, density, and credibility signals match the target expertise level
- [ ] Tone is consistent with the loaded `writing-style` context (if present)
- [ ] Output language matches the loaded `content-defaults` context (default: English
      unless project specifies otherwise)

### Persuasion

- [ ] 1–3 persuasion principles selected from the shared `persuasion-principles.md`,
      appropriate to the chosen audience / goal / stage combination
- [ ] No manufactured scarcity, fabricated proof, or authority-as-name-dropping
- [ ] At least one form of E-E-A-T signal is present (named author, original data,
      first-hand experience, named sources)
- [ ] Loss-aversion framing used at most once if present; no sustained catastrophizing

### Format-specific gates

- [ ] Image plan included: at least one image per ~300–400 words, with descriptive alt
      text noted in the draft (placeholders if visuals are produced separately)
- [ ] Single H1; H2 / H3 hierarchy is consistent and unambiguous
- [ ] If SEO is a stated goal: a 40–60-word direct answer to the main query appears
      near the top of the post (paragraph-snippet candidate)
- [ ] Meta description (~150–160 chars) is drafted as part of the deliverable
- [ ] If a brand-specific blog-rules document was loaded from context: every mandatory
      rule in that document is satisfied (e.g., mandatory sections, author-bio block,
      disclosure footers, internal-link counts)

### Closing

- [ ] The post can survive the "so what?" challenge on every paragraph
- [ ] The conclusion synthesizes — it does not summarize
- [ ] Internal-link suggestions are included where the chosen funnel stage implies a
      next-step page (TOFU → MOFU asset; MOFU → BOFU page; BOFU → conversion page)
