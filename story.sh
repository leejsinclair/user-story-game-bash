#!/bin/bash

# Define variables
userName=""
featureDescription=""
outcomeDescription=""

# Define constants
MAX_SCORE=100
NUM_HASHES_PER_POINT=2

echo "This script helps you create user stories."
echo "A user story is a short, informal explanation of a software feature."
echo "It describes the user who wants the feature, what they want, and why they want it."
echo "To create a user story, you will be prompted to answer three questions:"
echo "1. As a (.e.g. Customer):"
echo "2. I want (e.g. Collect coins): "
echo "3. So that (e.g. I have a feeling of accomplishment): "
echo

echo "Let's start..."

# Loop until the user exits
while true; do
    userScore=0
    featureScore=0
    outcomeScore=0
    score=0
    currentUserName=""
    currentFeatureDescription=""
    currentOutcomeDescription=""
    
    # Prompt the user for the user name
    read -e -p "As a ... " -i "$userName" currentUserName
    
    # Prompt the user for the feature description
    read -e -p "I want to ... " -i "$featureDescription" currentFeatureDescription
    
    # Prompt the user for the outcome description
    read -e -p "So that ... " -i "$outcomeDescription" currentOutcomeDescription
    
    # Calculate the score
    if [[ -n $userName ]]; then
        if [[ ${#userName} -lt 5 ]]; then
            userScore=$(( userScore + 0 ))
            elif [[ ${#userName} -lt 30 ]]; then
            userScore=$(( userScore + 10 ))
            elif [[ ${#userName} -lt 50 ]]; then
            userScore=$(( userScore + 5 ))
        else
            userScore=$(( userScore + 0 ))
        fi
    fi
    
    # Calculate the score
    if [[ -n $currentFeatureDescription ]]; then
        if [[ ${#currentFeatureDescription} -lt 10 ]]; then
            featureScore=$(( featureScore + 0 ))
            elif [[ ${#currentFeatureDescription} -lt 20 ]]; then
            featureScore=$(( featureScore + 10 ))
            elif [[ ${#currentFeatureDescription} -lt 50 ]]; then
            featureScore=$(( featureScore + 30 ))
            elif [[ ${#currentFeatureDescription} -lt 80 ]]; then
            featureScore=$(( featureScore + 40 ))
            elif [[ ${#currentFeatureDescription} -lt 110 ]]; then
            featureScore=$(( featureScore + 45 ))
            elif [[ ${#currentFeatureDescription} -lt 150 ]]; then
            featureScore=$(( featureScore + 20 ))
        else
            featureScore=$(( featureScore + 10 ))
        fi
    fi
    
    if [[ -n $currentOutcomeDescription ]]; then
        if [[ ${#currentOutcomeDescription} -lt 10 ]]; then
            outcomeScore=$(( outcomeScore + 0 ))
            elif [[ ${#currentOutcomeDescription} -lt 20 ]]; then
            outcomeScore=$(( outcomeScore + 10 ))
            elif [[ ${#currentOutcomeDescription} -lt 50 ]]; then
            outcomeScore=$(( outcomeScore + 30 ))
            elif [[ ${#currentOutcomeDescription} -lt 80 ]]; then
            outcomeScore=$(( outcomeScore + 40 ))
            elif [[ ${#currentOutcomeDescription} -lt 110 ]]; then
            outcomeScore=$(( outcomeScore + 45 ))
            elif [[ ${#currentOutcomeDescription} -lt 150 ]]; then
            outcomeScore=$(( outcomeScore + 20 ))
        else
            outcomeScore=$(( outcomeScore + 10 ))
        fi
    fi
    
    score=$((userScore + featureScore + outcomeScore))
    
    # Calculate the final score
    finalScore=$(( score * 100 / MAX_SCORE ))
    progressBarLength=$(( finalScore / NUM_HASHES_PER_POINT ))
    fullLength=$(( MAX_SCORE / NUM_HASHES_PER_POINT ))
    
    # Print story
    printf "\n----------------------------------\n"
    printf "As \e[1m$currentUserName\e[0m I want to \e[1m$currentFeatureDescription\e[0m so that \e[1m$currentOutcomeDescription\e[0m"
    printf "\n----------------------------------\n"
    # Print the score as progress bar
    printf "Score: "
    printf "%0.2f" "$finalScore"
    printf "%s" ""
    
    printf " ["
    for (( i = 0; i < progressBarLength; i++ )); do
        printf "#"
    done
    
    for (( i = progressBarLength; i < fullLength; i++ )); do
        printf " "
    done
    
    printf "]"
    
    echo
    
    userName=$currentUserName
    featureDescription=$currentFeatureDescription
    outcomeDescription=$currentOutcomeDescription
    
    if [ $finalScore -lt 5 ]; then
        echo "Hmm you might need to type something"
    elif [ $finalScore -lt 33 ]; then
        echo "We're off, let's try again"
    elif [ $finalScore -lt 50 ]; then
        echo "It's a start"
    elif [ $finalScore -lt 80 ]; then
        echo "This is a story"
    elif [ $finalScore -lt 90 ]; then
        echo "Just a bit more"
    else
        echo "Super star!"
    fi
    
    
    # Prompt the user to continue
    echo
    echo
    echo "Update and try again? (y/n) "
    read continue
    
    # Exit if the user enters "n"
    if [[ $continue == "n" ]]; then
        break
    fi
done
