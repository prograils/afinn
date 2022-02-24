# frozen_string_literal: true

require_relative "../lib/afinn"

RSpec.describe Afinn do
  it "creates the correct score for empty string" do
    afinn = described_class.new

    text = ""
    score = afinn.score(text)
    expect(score).to be 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :neutral
  end

  it "creates the correct score english score for bad words" do
    afinn = described_class.new

    text = "bad"
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative
  end

  it "creates the correct danish score for bad words" do
    afinn = described_class.new(language = :da)

    text = "dårligt"
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative
  end

  it "creates the correct score for emoticons" do
    afinn = described_class.new(language = :en, emoticons = true)

    score = afinn.score(":-)")
    expect(score).to be > 0
    score = afinn.score_to_words(":-)")
    expect(score).to be :positive

    score = afinn.score(":-(")
    expect(score).to be < 0
    score = afinn.score_to_words(":-(")
    expect(score).to be :negative

    score = afinn.score(":-|")
    expect(score).to be -1.0
    score = afinn.score_to_words(":-|")
    expect(score).to be :neutral

    score = afinn.score("<3")
    expect(score).to be > 0
    score = afinn.score_to_words("<3")
    expect(score).to be :positive
  end

  it "creates the correct score for emoticons and words (English)" do
    afinn = described_class.new(language = :en, emoticons = true)

    text = "Awesome XOXO"
    score = afinn.score(text)
    expect(score).to be > 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :positive

    text = "Bad product! :("
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative

    text = "I love this <3"
    score = afinn.score(text)
    expect(score).to be > 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :positive

    text = "Average :| Service could be better."
    score = afinn.score(text)
    expect(score).to be 1.0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :neutral

    text = "Great stadium for events.
      Went to see the car racing with Monster trucks and firework display.
      Was a very disappointing night due to car racing pretty much none existent because they we're just stuck in the mud.
      Monster trucks cancelled which the kids we're upset about. Food was extortionate priced along with drinks.
      The only thing that was good about the event was the fireworks right at the end.
      Would definitely not go to this event next year. What a complete shambles!!!!!"
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative

    text = "If you ever need to contact them it’s the worst and terrible place to call
      - phone not being answered for hours  but when you come in the reception they are sitting and talking
      between each other while phone lines are ringing non stop. Was calling a morning before the appointment
      to confirm the time but because nobody never answered the phone we missed an appointment and when came
      to reception said we can’t disclose information of what time your grandfather’s appointment is. Just ridiculous!"
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative

    text = "I'm a local lad. Raised right next door to this place and Bowling Park so both hold fond
      memories for me and my family. Passed my driving test recently and the first place I wanted to take my missus
      and 1 year old daughter was here. Still wonderful. So fascinating. Got lots of lovely photos of my baby's first visit.
      Staff are lovely, helpful and passionate about the place. Full of interesting trivia and knowledge.
      Made a donation and bought some cute keepsakes from the gift shop.
      Also I'm a descendant of the family who owned it some time ago, so there's that cool fact :)"
    score = afinn.score(text)
    expect(score).to be > 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :positive
  end

  it "creates the correct score for emoticons and words (Danish)" do
    afinn = described_class.new(language = :da, emoticons = true)

    text = "Jeg anbefaler ikke denne restaurant! Maden var forkælet. :("
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative

    text = "Moderate priser, udvidet åbningstider, gratis parkering og der er altid fri parkeringsplads. :|"
    score = afinn.score(text)
    expect(score).to be 0.0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :neutral

    text = "Jeg synes det er en god butik med mange gode
      Varer, dog til tider lidt for mange ting og rodde igennem i spot varene.
      Har et par gange osse købt nogen grøntsager der ikke var super friske men jeg kigger mere grundigt nu.
      Generelt mange spændene spot varer hver uge og generelt bredt udvalg.
      Ren butik :)."
    score = afinn.score(text)
    expect(score).to be > 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :positive

    text = "Virkelig fantastisk ret nyt rekreativ område i en gammel grusgrav. :D
      Her kan du fiske, svømme, spille fodbold, cykle på mountainbike på de gode stier,
      gå på opdagelse efter trolde eller måske lave pizza i pizzaovnen. Perfekt til dig der eksempelvis skal på caminoen.
      Er du blevet træt kan du overnatte i en shelter eller bare nyde livet på en bænk eller
      lave mad på en af de mange grillpladser."
    score = afinn.score(text)
    expect(score).to be > 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :positive

    text = "Rigtig god skole. Der er et godt sammenhold mellem eleverne og en god dynamik på skolen. :P
      Det er en skole hvor man udvikler sig personligt samt fagligt og lærerne er meget kompetente til at hjælpe
      de studerende med fremtidige muligheder."
    score = afinn.score(text)
    expect(score).to be > 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :positive

    text = "Det var en meget forvirret oplevelse, priserne der var over og under varerne passede
      ikke med varerne omkring, de ansatte i butikken havde mere travlt med at snakke i hørersæt med hinanden,
      om personlige ting, end at betjene kunderne. :/"
    score = afinn.score(text)
    expect(score).to be < 0
    score_to_words = afinn.score_to_words(text)
    expect(score_to_words).to be :negative
  end
end
