extends Node

# 🐈 CATastrophy — Master TODO List
# A punishing action-roguelite about sin, weapons, and bad decisions.
# Name is a pun for "CAT"-astrophy.

# ==================================================
# 🧠 CORE DESIGN (FOUNDATION)
# ==================================================

# FIXME: Finalize core fantasy (player fantasy in 1 sentence)
# FIXME: Lock 7-rule philosophy (everything comes in 7s)
# TODO: Decide camera + input style (top-down twin-stick / mouse aim)

# ==================================================
# ⚙️ CORE MECHANICS
# ==================================================

# --- Damage System ---
# TODO: Implement Armor vs Core separation
# TODO: Implement damage types (Shred / Pierce / Elemental)
# TODO: Define damage resolution order
# TODO: Implement armor piece HP & break states
# TODO: Define core vulnerability rules

# --- Crit System (Unified) ---
# TODO: Implement crit as "chance for weapon to function optimally"
# TODO: Armor crit → chance to break armor
# TODO: Pierce crit → chance to pierce armor
# TODO: Elemental crit → chance to apply debuff
# TODO: Scale crit chance with armor integrity

# ==================================================
# 😾 CATALYST SYSTEM (7 SINS)
# ==================================================

# --- Catalyst Core ---
# TODO: Enforce one Catalyst active at a time
# TODO: Apply passive pros/cons globally
# TODO: Implement unique effect per Catalyst
# TODO: Implement unique negative per Catalyst
# TODO: Define synergy rules (what stacks / what never does)

# --- Individual Catalyst Pass ---
# TODO: Finalize Wrath (Fire)
# TODO: Finalize Greed (Earth)
# TODO: Finalize Pride (Lightning)
# TODO: Finalize Envy (Shadow)
# TODO: Finalize Lust (Wind)
# TODO: Finalize Gluttony (Water)
# TODO: Finalize Sloth (Ice)

# TODO: Lock passive stats per Catalyst
# TODO: Lock effect identity per Catalyst
# TODO: Lock negative effect per Catalyst
# TODO: Define visual language per Catalyst
# TODO: Define sound identity per Catalyst

# ==================================================
# ✨ STATUS & STRESS SYSTEMS
# ==================================================

# --- Status Effects ---
# TODO: Implement Burn
# TODO: Implement Slow
# TODO: Implement Stun
# TODO: Implement Corrode
# TODO: Implement Charm
# TODO: Implement Life Steal
# TODO: Implement Money Shot

# --- Stress / Sin States ---
# TODO: Implement Volatile
# TODO: Implement Tax
# TODO: Implement Starve
# TODO: Implement Jealousy
# TODO: Implement Fatigue
# TODO: Implement Frostbite
# TODO: Implement Humbled

# TODO: Define triggers for all statuses
# TODO: Define duration rules
# TODO: Define visual feedback
# TODO: Define how player clears statuses

# ==================================================
# 🗡️ WEAPONS (7 TOTAL)
# ==================================================

# --- Global Weapon Rules ---
# TODO: Support multiple damage types per weapon
# TODO: Ensure each weapon feels unique with same Catalyst
# TODO: Weapon controls hit logic; Catalyst modifies behavior

# --- Individual Weapons ---
# TODO: Implement Bow
# TODO: Implement Hand Cannon
# TODO: Implement Throwable Blades
# TODO: Implement Magic Staff
# TODO: Implement Spear Caller
# TODO: Implement Explosive Catalysts
# TODO: Implement Grimoire

# TODO: Define base damage profile per weapon
# TODO: Define damage type ratios per weapon
# TODO: Define core interaction rules
# TODO: Define armor interaction rules
# TODO: Add animation & feedback hooks

# ==================================================
# 📖 GRIMOIRE SYSTEM
# ==================================================

# TODO: Define spell slots
# TODO: Finalize Unleash mechanic
# TODO: Implement spell charge logic
# TODO: Define resource interaction
# TODO: Tune risk vs reward
# TODO: Improve UI clarity for Unleash state

# ==================================================
# 💨 UTILITY SKILLS (7 TOTAL)
# ==================================================

# --- Global Rules ---
# TODO: Enforce Tap / Hold behavior for all utilities
# TODO: Tap = reactive / mobility
# TODO: Hold = commitment / power
# TODO: Define cancel rules

# --- Individual Utilities ---
# TODO: Wrath — Charge / Blast Dash
# TODO: Greed — Hook
# TODO: Pride — Teleport
# TODO: Envy — Shadow Step
# TODO: Lust — Siren’s Flight
# TODO: Gluttony — Devouring Tide
# TODO: Sloth — Ice Bastion

# TODO: Implement tap/hold logic for each utility
# TODO: Balance cooldowns and commitment cost

# ==================================================
# 🤖 ENEMIES
# ==================================================

# TODO: Implement enemy armor pieces
# TODO: Implement enemy weapon systems
# TODO: Implement mobility parts
# TODO: Implement core exposure logic

# TODO: Create light enemies
# TODO: Create armored enemies
# TODO: Create swarm enemies
# TODO: Create snipers
# TODO: Create elites
# TODO: Build boss framework

# ==================================================
# 🧭 PROGRESSION
# ==================================================

# TODO: Define meta vs run progression
# TODO: Implement weapon unlock rules
# TODO: Implement Catalyst discovery
# TODO: Define difficulty scaling
# TODO: Punish over-specialization

# ==================================================
# 🎨 UI / UX
# ==================================================

# TODO: Improve damage feedback clarity
# TODO: Add armor break indicators
# TODO: Add core hit indicators
# TODO: Build Catalyst HUD
# TODO: Add Tap/Hold utility indicator
# TODO: Improve status effect readability

# ==================================================
# 🔊 AUDIO & FEEL
# ==================================================

# TODO: Define sound identity per Catalyst
# TODO: Add armor break sound tiers
# TODO: Add core hit crit sound
# TODO: Add utility charge audio
# TODO: Use silence as feedback (Sloth)

# ==================================================
# 📚 DOCUMENTATION
# ==================================================

# TODO: Maintain Obsidian as source of truth
# TODO: Keep HTML export consistent
# TODO: Sync README.md and README.html
# TODO: Enforce terminology consistency
# TODO: Remove outdated mechanics

# ==================================================
# 🧪 PLAYTEST CHECKLIST
# ==================================================

# FIXME: Is hiding ever optimal?
# FIXME: Does Greed feel dangerous?
# FIXME: Can player brute-force one Catalyst?
# FIXME: Do Tap/Hold decisions feel meaningful?
# FIXME: Does breaking armor feel good?

# ==================================================
# 🚨 DESIGN QUESTIONS (INTENTIONAL UNANSWERED)
# ==================================================

# HACK: What makes CATastrophy unforgiving?
# HACK: Why should the player switch Catalysts?
# HACK: What mistake kills most new players?
# HACK: What mistake experts still make?
