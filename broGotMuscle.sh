#!/bin/bash

DB="broGotMuscle.db"
TABLE="body_comp"

# Initialize the database and table if not exists
init_db() {
    sqlite3 "$DB" <<EOF
CREATE TABLE IF NOT EXISTS $TABLE (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    age INTEGER NOT NULL,
    height REAL NOT NULL,
    weight REAL NOT NULL,
    skeletal_mus REAL NOT NULL,
    fat_mass REAL NOT NULL,
    body_water REAL NOT NULL,
    lean_body_mass REAL NOT NULL,
    bmi REAL NOT NULL,
    fat_percent REAL NOT NULL,
    whr REAL NOT NULL,
    visceral_fat INTEGER NOT NULL,
    basal_metabolism REAL NOT NULL,
    seg_mus_rarm REAL NOT NULL,
    seg_mus_larm REAL NOT NULL,
    seg_mus_torso REAL NOT NULL,
    seg_mus_rleg REAL NOT NULL,
    seg_mus_lleg REAL NOT NULL,
    seg_fat_rarm REAL NOT NULL,
    seg_fat_larm REAL NOT NULL,
    seg_fat_torso REAL NOT NULL,
    seg_fat_rleg REAL NOT NULL,
    seg_fat_lleg REAL NOT NULL,
    seg_fat_percent_rarm REAL NOT NULL,
    seg_fat_percent_larm REAL NOT NULL,
    seg_fat_percent_torso REAL NOT NULL,
    seg_fat_percent_rleg REAL NOT NULL,
    seg_fat_percent_lleg REAL NOT NULL,
    muscle REAL NOT NULL,
    fat REAL NOT NULL,
    health_score INTEGER NOT NULL,
    physical_age INTEGER NOT NULL
);
EOF
}

# Add entry
add_entry() {
    echo "Enter new entry."
    echo ""
    echo "----------------------"
    echo " General Data"
    echo "----------------------"
    echo ""
    read -p "Date (YYYY-MM-DD) [Empty = Today] : " date_input
    read -p "Age : " age
    read -p "Height (CM) : " height
    read -p "Weight (KG) : " weight

    echo ""
    echo "----------------------"
    echo " Body Composition Analysis"
    echo "----------------------"
    echo ""
    read -p "Skeletal muscle (KG) : " skeletal_mus
    read -p "Fat mass (KG) : " fat_mass
    read -p "Body water (KG) : " body_water
    read -p "Lean body mass (KG) : " lean_body_mass

    echo ""
    echo "----------------------"
    echo " Obesity Analysis"
    echo "----------------------"
    echo ""
    read -p "BMI : " bmi
    read -p "Fat percentage (%) : " fat_percent
    read -p "WHR : " whr
    read -p "Visceral fat grade : " visceral_fat
    read -p "Basal metabolism (Kcal) : " basal_metabolism

    echo ""
    echo "----------------------"
    echo " Segmental Muscle"
    echo "----------------------"
    echo ""
    read -p "Right arm (KG) : " seg_mus_rarm
    read -p "Left arm (KG) : " seg_mus_larm
    read -p "Torso (KG) : " seg_mus_torso
    read -p "Right leg (KG) : " seg_mus_rleg
    read -p "Left leg (KG) : " seg_mus_lleg
    
    echo ""
    echo "----------------------"
    echo " Segmental Fat"
    echo "----------------------"
    echo ""
    read -p "Right arm (KG) : " seg_fat_rarm
    read -p "Right arm (%) : " seg_fat_percent_rarm
    read -p "Left arm (KG) : " seg_fat_larm
    read -p "Left arm (%) : " seg_fat_percent_larm
    read -p "Torso (KG) : " seg_fat_torso
    read -p "Torso (%) : " seg_fat_percent_torso
    read -p "Right leg (KG) : " seg_fat_rleg
    read -p "Right leg (%) : " seg_fat_percent_rleg
    read -p "Left leg (KG) : " seg_fat_lleg
    read -p "Left leg (%) : " seg_fat_percent_lleg

    echo ""
    echo "----------------------"
    echo " Muscle & Fat Control"
    echo "----------------------"
    echo ""
    read -p "Muscle (KG) : " muscle
    read -p "Fat (KG) : " fat

    echo ""
    echo "----------------------"
    echo " Score"
    echo "----------------------"
    echo ""
    read -p "Helath score : " health_score
    read -p "Physical age : " physical_age

    # Use today's date if not provided
    if [ -z "$date_input" ]; then
        date_input=$(date +%F)
    fi

    sqlite3 "$DB" "INSERT INTO $TABLE (
    date,
    age,
    height,
    weight,
    skeletal_mus,
    fat_mass,
    body_water,
    lean_body_mass,
    bmi,
    fat_percent,
    whr,
    visceral_fat,
    basal_metabolism,
    seg_mus_rarm,
    seg_mus_larm,
    seg_mus_torso,
    seg_mus_rleg,
    seg_mus_lleg,
    seg_fat_rarm,
    seg_fat_larm,
    seg_fat_torso,
    seg_fat_rleg,
    seg_fat_lleg,
    seg_fat_percent_rarm,
    seg_fat_percent_larm,
    seg_fat_percent_torso,
    seg_fat_percent_rleg,
    seg_fat_percent_lleg,
    muscle,
    fat,
    health_score,
    physical_age
    ) VALUES (
    $date_input,
    $age,
    $height,
    $weight,
    $skeletal_mus,
    $fat_mass,
    $body_water,
    $lean_body_mass,
    $bmi,
    $fat_percent,
    $whr,
    $visceral_fat,
    $basal_metabolism,
    $seg_mus_rarm,
    $seg_mus_larm,
    $seg_mus_torso,
    $seg_mus_rleg,
    $seg_mus_lleg,
    $seg_fat_rarm,
    $seg_fat_larm,
    $seg_fat_torso,
    $seg_fat_rleg,
    $seg_fat_lleg,
    $seg_fat_percent_rarm,
    $seg_fat_percent_larm,
    $seg_fat_percent_torso,
    $seg_fat_percent_rleg,
    $seg_fat_percent_lleg,
    $muscle,
    $fat,
    $health_score,
    $physical_age
    );"
    echo "New entry added to database!"
}

# List all entry
list_data() {
    echo "All your data"
    sqlite3 "$DB" <<EOF
.headers on
.mode column
SELECT * FROM $TABLE ORDER BY date;
EOF
}

# Main entry
init_db

case "$1" in
    add) add_entry ;;
    list) list_data ;;
esac
