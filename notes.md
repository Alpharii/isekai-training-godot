**Structure (plan) :**
```
res://
├── scenes/
│   ├── main/
│   │   ├── main_menu.tscn
│   │   ├── game.tscn
│   │   └── result.tscn
│   │
│   ├── training/
│   │   ├── training_screen.tscn
│   │   ├── training_button.tscn
│   │   └── training_result.tscn
│   │
│   ├── events/
│   │   ├── event_popup.tscn
│   │   └── choice_popup.tscn
│   │
│   └── character/
│       ├── character_card.tscn
│       └── character_detail.tscn
│
├── scripts/
│   ├── managers/
│   │   ├── save_manager.gd
│   │   ├── game_manager.gd
│   │   ├── event_manager.gd
│   │   └── training_manager.gd
│   │
│   ├── data/
│   │   ├── player_data.gd
│   │   ├── character_data.gd
│   │   └── run_data.gd
│   │
│   └── ui/
│       ├── training_screen.gd
│       └── event_popup.gd
│
├── resources/
│   ├── characters/
│   │   ├── alice.tres
│   │   └── bella.tres
│   │
│   ├── events/
│   │   ├── event_001.tres
│   │   └── event_002.tres
│   │
│   └── training/
│       ├── strength.tres
│       └── speed.tres
│
├── saves/
│
├── assets/
│   ├── images/
│   ├── audio/
│   └── fonts/
│
└── autoload/
    ├── game_manager.gd
    └── save_manager.gd
```

---

**Stats (plan) :**

strength
endurance
magic
wisdom
dexterity
agility

---

**Save (plan) :**
{
  "character_name": "alphari",

  "turn": 25,

  "stats": {
    "strength": 120,
    "endurance": 90,
    "magic": 110,
    "wisdom" : 100,
    "dexterity": 70,
    "agility": 50
  },

  "hp": 70,

  "stress": 25,

  "money": 5000,

  "inventory": [
    "protein",
    "energy_drink"
  ],

  "events_seen": [
    "event_001",
    "event_015"
  ]
}

---

**Training flow**

{
  "id": "speed_training",

  "name": "Sprint",

  "cost_hp": 10,

  "gain": {
    "speed": 15,
    "power": 3
  },

  "stress": 5
}

Sprint
↓
HP -10
Speed +15
Power +3
Stress +5

**gameplay / flow game :**

```
Main Menu
    ↓
Select Character
    ↓
Training Run
    ↓
Turn 1
    ↓
Training or Rest or Event
    ↓
Turn 2
    ↓
Training or Event
    ↓
........
    ↓
Turn 25
    ↓
Final Result
    ↓
Save Record
```