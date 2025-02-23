# Compositional Layout

## Overview

Compositional Layout, introduced in iOS 13, is a modern, declarative way to build adaptive and complex collection view layouts. By structuring your layout into items, groups, and sections, you can create interfaces that adjust smoothly to different screen sizes and orientations.

## Introduction

**Compositional Layout** simplifies the creation of complex collection view layouts by letting you declaratively define items, groups, and sections. This approach removes the need for manual frame calculations and makes it easier to build adaptive interfaces.

## Key Concepts

- **Items**: The basic elements corresponding to individual collection view cells.
- **Groups**: Containers that arrange one or more items either horizontally or vertically.
- **Sections**: Organize groups; can also include supplementary (headers/footers) and decoration views.
- **Dimensions**:
  - **Fractional**: `.fractionalWidth` and `.fractionalHeight`—relative to the container.
  - **Absolute**: Fixed size in points using `.absolute`.
  - **Estimated**: The system calculates size based on content.
- **Supplementary Views**: Headers, footers, or other context-providing views.
- **Decoration Views**: Background or decorative elements for a section.

## Basic Setup

### Defining an Item

An item is the smallest layout unit representing a collection view cell:

```swift
let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                      heightDimension: .absolute(50))
let item = NSCollectionLayoutItem(layoutSize: itemSize)
```

### Creating a Group

Arrange items into a group. Here’s an example of a horizontal group containing a single item:

```swift
let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                       heightDimension: .absolute(50))
let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
```

### Configuring a Section

Customize your section by adding content insets and spacing:

```swift
let section = NSCollectionLayoutSection(group: group)
section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
section.interGroupSpacing = 10
```

### Assigning the Layout

Create and assign the compositional layout to your collection view:

```swift
let layout = UICollectionViewCompositionalLayout(section: section)
collectionView.collectionViewLayout = layout
```


### Nested Groups

Build more intricate layouts by nesting groups within groups:

```swift
// Define a smaller item
let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                           heightDimension: .fractionalHeight(1.0))
let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
smallItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

// Create an inner vertical group
let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                            heightDimension: .absolute(100))
let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize,
                                                  subitem: smallItem,
                                                  count: 2)

// Define a full-width item
let fullItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                          heightDimension: .absolute(100))
let fullItem = NSCollectionLayoutItem(layoutSize: fullItemSize)
fullItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

// Combine into an outer group
let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(100))
let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize,
                                                     subitems: [innerGroup, fullItem])
```

### Orthogonal Scrolling

Enable sections that scroll independently (horizontally within a vertical collection view):

```swift
let orthogonalSection = NSCollectionLayoutSection(group: group)
orthogonalSection.orthogonalScrollingBehavior = .continuous
```

### Supplementary and Decoration Views

#### Supplementary Views

Add a header to provide context for a section:

```swift
let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                        heightDimension: .estimated(44))
let header = NSCollectionLayoutBoundarySupplementaryItem(
    layoutSize: headerSize,
    elementKind: UICollectionView.elementKindSectionHeader,
    alignment: .top)
section.boundarySupplementaryItems = [header]
```



full example 

``` swift
private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createLayout(for: sectionIndex)
        }
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
    }

    private func createLayout(for section: Int) -> NSCollectionLayoutSection {
        switch section {
        case 0:
            return createHorizontalSection()
        case 1:
            return createGridSection()
        default:
            return createGridSection()
        }
    }

    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return section
    }

    private func createGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return section
    }
```
