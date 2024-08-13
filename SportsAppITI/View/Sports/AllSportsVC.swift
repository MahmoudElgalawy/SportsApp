import UIKit

class AllSportsVC: UIViewController {

    // MARK: - Properties
    private var viewModel: AllSportsViewModel?
    private var isOrthogonal: Bool = true
    var initialSportsItems: [SportsItemModel] = []

    @IBOutlet private var orthogonalLayoutButton: UIBarButtonItem!
    @IBOutlet private var sportsCollectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
        updateLayoutButtonImage()
    }

    // MARK: - Setup Methods
    private func setupCollectionView() {
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        sportsCollectionView.register(UINib(nibName: CellId.AllSportsCell, bundle: nil), forCellWithReuseIdentifier: CellId.AllSportsCell)
    }

    private func setupViewModel() {
         initialSportsItems = [
            SportsItemModel(imgName: "football", titleName: "Football"),
            SportsItemModel(imgName: "basketball", titleName: "Basketball"),
            SportsItemModel(imgName: "cricket", titleName: "Cricket"),
            SportsItemModel(imgName: "tennis", titleName: "Tennis")
        ]
        viewModel = AllSportsViewModel(sportsItems: initialSportsItems)
    }

    private func updateLayoutButtonImage() {
        let imageName = isOrthogonal ? "square.grid.2x2" : "list.bullet"
        orthogonalLayoutButton.image = UIImage(systemName: imageName)
    }

    // MARK: - Actions
    @IBAction private func sortingButtonPressed(_ sender: UIBarButtonItem) {
        isOrthogonal.toggle()
        updateLayoutButtonImage()
        sportsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension AllSportsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sportsItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.AllSportsCell, for: indexPath) as? AllSportsCell else {
            return UICollectionViewCell()
        }
        if let model = viewModel?.sportsItems[indexPath.row] {
            cell.configure(with: model)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AllSportsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isOrthogonal {
            let numberOfCellsInRow: CGFloat = 2
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 10

            let collectionViewWidth = collectionView.bounds.width
            let spacingBetweenCells = flowLayout.minimumInteritemSpacing * (numberOfCellsInRow - 1)
            let adjustedWidth = collectionViewWidth - spacingBetweenCells
            let width = adjustedWidth / numberOfCellsInRow

            return CGSize(width: width - 10, height: width)
        } else {
            return CGSize(width: collectionView.bounds.width-20, height: collectionView.bounds.height / 4)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AllSportsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let sportsName = initialSportsItems[indexPath.row].titleName
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SportTV") as? SportTV else { return }
        vc.sportsName = sportsName.lowercased()
        vc.title = sportsName
        navigationController?.pushViewController(vc, animated: true)
    }
}
