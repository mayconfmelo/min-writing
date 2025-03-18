#import "@preview/min-writing:0.1.0": glossary

#rect[
  This document import only the glossary-related features of _min-manual_. This
  is useful when just these commands are needed, and not the whole package.
]


= Abbreviations

#import glossary: abbrev

Abbreviations with definitions are automatically included in the glossary:
#abbrev("abnt")[Associação Brasileira de Normas Técnicas][Brazilian association
responsible for normatization and standardization.]

Abbreviations without definitions are automatically included as well:
#abbrev[idk][I don't know]

If a previous abbreviation is used again it will be automatically retrieved and
shown: #abbrev[abnt]


= Glossary Terms

#import glossary: gloss

Glossary terms are detailed and explained in tje glossary, along with the
abbreviations. They are automatically included in the glossary list of terms:
#gloss[saudade][Brazilian word with no direct translation; represents a feeling
of longing for a known someone or something, and a strong desire to have this
someone or something back.]


= Manual Glossary Insertion

#import glossary: insert-glossary

The glossary can be shown anywhere in the document, including right below:

#insert-glossary()

